defmodule Ulid.Utils do
  @encoding "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
  @mask 0x1F
  @bits 5

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
