defmodule Ulid.Utils do
  @encoding "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
  @mask 0x1F
  @bits 5

  def encoding, do: @encoding

  def concatenate_encodings(positions) do
    positions
      |> Enum.reduce("", fn(position, output) ->
          output <> String.at(@encoding, position)
        end)
      |> String.reverse
  end

  def encode(<<num::unsigned-size(128)>>) do
    encode(num, "") |> String.pad_leading(26, "0")
  end

  defp encode(0, acc), do: acc
  defp encode(n, acc) do
    index = :erlang.band(n, @mask)
    char = String.at(@encoding, index)
    encode(:erlang.bsr(n, @bits), char <> acc)
  end
end
