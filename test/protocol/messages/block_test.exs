defmodule Bitcoin.Protocol.Messages.BlockTest do
  use ExUnit.Case

  alias Bitcoin.Protocol.Messages.Block
  alias Bitcoin.Protocol.Messages.Tx
  alias Bitcoin.Protocol.Types.TransactionInput
  alias Bitcoin.Protocol.Types.TransactionOutput
  alias Bitcoin.Protocol.Types.Outpoint


  test "block 100_000" do
    # Block no 100_000 from the Bitcoin blockchain
    {:ok, payload} = File.read("test/data/blk_100000.dat")

    struct = %Block{
      version: 1,
      bits: 453281356,
      merkle_root: <<102, 87, 169, 37, 42, 172, 213, 192, 178, 148, 9, 150, 236, 255, 149, 34, 40, 195, 6, 124, 195, 141, 72, 133, 239, 181, 164, 172, 66, 71, 233,  243>>,
      previous_block: <<80, 18, 1, 25, 23, 42, 97, 4, 33, 166, 195, 1, 29, 211, 48, 217, 223, 7, 182, 54, 22, 194, 204, 31, 28, 208, 2, 0, 0, 0, 0, 0>>,
      timestamp: 1293623863,
      nonce: 274148111,
      transactions: [
          %Tx{
            inputs: [
              %TransactionInput{
                previous_output: %Outpoint{
                  hash: <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>,
                  index: 4294967295
                },
                sequence: 4294967295,
                signature_script: <<4, 76, 134, 4, 27, 2, 6, 2>>
              }
            ],
            lock_time: 0,
            outputs: [
              %TransactionOutput{
                pk_script: <<65, 4, 27, 14, 140, 37, 103, 193, 37, 54, 170, 19, 53, 123, 121, 160, 115, 220, 68, 68, 172, 184, 60, 78, 199, 160, 226, 249, 157, 215, 69, 117, 22, 197, 129, 114, 66, 218, 121, 105, 36, 202, 78, 153, 148, 125, 8, 127, 237, 249, 206, 70, 124, 185, 247, 198, 40, 112, 120, 248, 1, 223, 39, 111, 223, 132, 172>>,
                value: 5000000000
              }
            ],
            version: 1
          },
          %Tx{
            inputs: [
              %TransactionInput{
                previous_output: %Outpoint{
                  hash: <<3, 46, 56, 233, 192, 168, 76, 96, 70, 214, 135, 209, 5, 86, 220, 172, 196, 29, 39, 94, 197, 95, 192, 7, 121, 172, 136, 253, 243, 87, 161, 135>>,
                  index: 0
                },
                sequence: 4294967295,
                signature_script: <<73, 48, 70, 2, 33, 0, 195, 82, 211, 221, 153, 58, 152, 27, 235, 164, 166, 58, 209, 92, 32, 146, 117, 202, 148, 112, 171, 252, 213, 125, 169, 59, 88, 228, 235, 93, 206, 130, 2, 33, 0, 132, 7, 146, 188, 31, 69, 96, 98, 129, 159, 21, 211, 62, 231, 5, 92, 247, 181, 238, 26, 241, 235, 204, 96, 40, 217, 205, 177, 195, 175, 119, 72, 1, 65, 4, 244, 109, 181, 233, 214, 26, 157, 194, 123, 141, 100, 173, 35, 231, 56, 58, 78, 108, 161, 100, 89, 60, 37, 39, 192, 56, 192, 133, 126, 182, 126, 232, 232, 37, 220, 166, 80, 70, 184, 44, 147, 49, 88, 108, 130, 224, 253, 31, 99, 63, 37, 248, 124, 22, 27, 198, 248, 166, 48, 18, 29, 242, 179, 211>>}
            ],
            lock_time: 0,
            outputs: [
              %TransactionOutput{
                pk_script: <<118, 169, 20, 195, 152, 239, 169, 195, 146, 186, 96, 19, 197, 224, 78, 231, 41, 117, 94, 247, 245, 139, 50, 136, 172>>,
                value: 556000000
              },
              %TransactionOutput{
                pk_script: <<118, 169, 20, 148, 140, 118, 90, 105, 20, 212, 63, 42, 122, 193, 119, 218, 44, 47, 107, 82, 222, 61, 124, 136, 172>>,
                value: 4444000000}
            ],
            version: 1},
          %Tx{
            inputs: [
              %TransactionInput{
                previous_output: %Outpoint{
                  hash: <<195, 62, 191, 242, 167, 9, 241, 61, 159, 154, 117, 105, 171, 22, 163, 39, 134, 175, 125, 126, 45, 224, 146, 101, 228, 28, 97, 208, 120, 41, 78, 207>>,
                  index: 1
                },
            sequence: 4294967295,
            signature_script: <<71, 48, 68, 2, 32, 3, 45, 48, 223, 94, 230, 245, 127, 164, 108, 221, 181, 235, 141, 13, 159, 232, 222, 107, 52, 45, 39, 148, 42, 233, 10, 50, 49, 224, 186, 51, 62, 2, 32, 61, 238, 232, 6, 15, 220, 112, 35, 10, 127, 91, 74, 215, 215, 188, 62, 98, 140, 190, 33, 154, 136, 107, 132, 38, 158, 174, 184, 30, 38, 180, 254, 1, 65, 4, 174, 49, 195, 27, 249, 18, 120, 217, 155, 131, 119, 163, 91, 188, 229, 178, 125, 159, 255, 21, 69, 104, 57, 233, 25, 69, 63, 199, 179, 247, 33, 240, 186, 64, 63, 249, 108, 157, 238, 182, 128, 229, 253, 52, 28, 15, 195, 167, 185, 13, 164, 99, 30, 227, 149, 96, 99, 157, 180, 98, 233, 203, 133, 15>>}],
            lock_time: 0,
            outputs: [
              %TransactionOutput{
                pk_script: <<118, 169, 20, 176, 220, 191, 151, 234, 191, 68, 4, 227, 29, 149, 36, 119, 206, 130, 45, 173, 190, 126, 16, 136, 172>>,
                value: 1000000},
              %TransactionOutput{
                pk_script: <<118, 169, 20, 107, 18, 129, 238, 194, 90, 180, 225, 224, 121, 63, 244, 224, 138, 177, 171, 179, 64, 156, 217, 136, 172>>,
                value: 299000000}
            ],
            version: 1
          },
          %Tx{
            inputs: [
              %TransactionInput{
                previous_output: %Outpoint{
                  hash: <<11, 96, 114, 179, 134, 212, 167, 115, 35, 82, 55, 246, 76, 17, 38, 172, 59, 36, 12, 132, 185, 23, 163, 144, 155, 161, 196, 61, 237, 95, 81, 244>>,
                  index: 0},
                sequence: 4294967295,
                signature_script: <<73, 48, 70, 2, 33, 0, 187, 26, 210, 109, 249, 48, 165, 28, 206, 17, 12, 244, 79, 122, 72, 195, 197, 97, 253, 151, 117, 0, 177, 174, 93, 107, 111, 209, 61, 11, 63, 74, 2, 33, 0, 197, 180, 41, 81, 172, 237, 255, 20, 171, 186, 39, 54, 253, 87, 75, 219, 70, 95, 62, 111, 141, 161, 46, 44, 83, 3, 149, 74, 202, 127, 120, 243, 1, 65, 4, 167, 19, 91, 254, 130, 76, 151, 236, 192, 30, 199, 215, 227, 54, 24, 92, 129, 226, 170, 44, 65, 171, 23, 84, 7, 192, 148, 132, 206, 150, 148, 180, 73, 83, 252, 183, 81, 32, 101, 100, 169, 194, 77, 208, 148, 212, 47, 219, 253, 213, 170, 211, 224, 99, 206, 106, 244, 207, 170, 234, 78, 161, 79, 187>>}
            ], lock_time: 0,
            outputs: [
              %TransactionOutput{
                pk_script: <<118, 169, 20, 57, 170, 61, 86, 158, 6, 161, 215, 146, 109, 196, 190, 17, 147, 201, 155, 242, 235, 158, 224, 136, 172>>, value: 1000000}
            ],
            version: 1}
        ]
      }

    assert Block.parse(payload) == struct
    assert Block.serialize(struct) == payload
  end
end
