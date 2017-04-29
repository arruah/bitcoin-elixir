defmodule Bitcoin.DERSig do

  @moduledoc """
  DER Signature.

  DER encoded signatures are used in Bitcoin scripts (with sighash byte at the end).

  This module provides parsing, serialization, normalization and checking if
  the signature meets BIP66 requirements.

  We need to normalize signatures before passing them to erlang's :crypto.verify
  because it will return false if R or S are zero padded (while libsecp256k1 returns true).

  DER Signature format:

  `<<type, total_length, 0x02, r_length, r :: binary, 0x02, s_length, s :: binary>>`

  Plus sighash byte at the end for the signatures present in the script, but this module
  deals with signatures that already have the sighash byte stripped.
  """

  use Bitwise

  defstruct [:length, :r, :s, :type]

  @type t :: %__MODULE__{}

  @doc """
  Parse binary signature into %DERSig{} struct.
  """
  @spec parse(binary) :: t
  def parse(sig) do
    <<type, total_length, sig :: binary>> = sig

    <<0x02, r_length, sig :: binary>> = sig
    <<r :: binary-size(r_length), sig :: binary>> = sig

    <<0x02, s_length, sig :: binary>> = sig
    <<s :: binary-size(s_length)>> = sig

    %__MODULE__{
      length: total_length,
      type: type,
      r: r,
      s: s
    }
  end

  @doc """
  Serialize signature struct into binary.

  `length` from the struct is used in serialization, even if it's incorrect.
  """
  @spec serialize(t) :: binary
  def serialize(%__MODULE__{} = der) do
    <<der.type, der.length, 0x02, byte_size(der.r), der.r :: binary, 0x02, byte_size(der.s), der.s :: binary>>
  end

  @doc """
  Normalize DER signature.

  Which in our case means only removing leading null bytes from R and S
  and fixing the total_length if it's incorrect.
  """
  @spec normalize(t | binary) :: t | binary
  def normalize(sig)

  def normalize(sig) when is_binary(sig) do
    sig
    |> parse
    |> normalize
    |> serialize
  end

  def normalize(%__MODULE__{} = der) do
    r = trim(der.r)
    s = trim(der.s)
    der
    |> Map.put(:r, r)
    |> Map.put(:s, s)
    |> Map.put(:length, byte_size(r) + byte_size(s) + 4)
  end

  @doc """
  Check if the signature is a strict DER signature (BIP66)

  https://github.com/bitcoin/bips/blob/master/bip-0066.mediawiki

  Note that we operate on sig that already has the sighash byte stripped.
  """
  @spec strict?(binary) :: boolean
  def strict?(sig) when is_binary(sig) do
    der = parse(sig)
    cond do
      # Minimum size constraint
      byte_size(sig) < 8
        -> false

      # Maximum size constraint
      byte_size(sig) > 72
        -> false

      # A signature is of type 0x30 (compound).
      der.type != 0x30
        -> false

      # Length covers the entire signature
      der.length != byte_size(sig) - 2
        -> false

      # Make sure the length of the S element is still inside the signature
      # -> Our parser will currently raise if it's not

      # Length of the signature matches the sum of the length of the elements
      # -> Parser does not allow any bytes left unused

      # R element is an integer.
      # -> Parser already makes sure the byte before R length is 0x02

      # R length > 0
      der.r == <<>>
        -> false

      # R is positive
      (Binary.at(sig, 4) &&& 0x80) == 0x80
        -> false

      # No unecessary null bytes at the start of R
      trim(der.r) != der.r
        -> false

      # Check whether the S element is an integer.
      # -> Parser already makes sure the byte before S length is 0x02

      # S length > 0
      der.s == <<>>
        -> false

      # S is not negative
      (Binary.at(der.s, 0) &&& 0x80) == 0x80
        -> false

      # No unecessary null bytes at the start of S
      trim(der.s) != der.s
        -> false

      # All passed
      true -> true
    end
  end

  # Trim leading null bytes
  # But we need to be careful because if the null byte is followed by a byte with 0x80 bit set,
  # removing the null byte would change the number sign.
  defp trim(<<0, b, _bin :: binary>> = sig) when (b &&& 0x80) == 0x80, do: sig
  defp trim(<<0, bin :: binary>>), do: trim(bin)
  defp trim(bin), do: bin

end