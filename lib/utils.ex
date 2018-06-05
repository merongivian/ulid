defmodule Ulid.Utils do
  @encoding "0123456789ABCDEFGHJKMNPQRSTVWXYZ"

  def encode(<<_::unsigned-size(128)>> = bytes), do: encode_bytes(<<0::2, bytes::binary>>, <<>>)

  defp encode_bytes(<<index::unsigned-size(5), rest::bitstring>>, acc) do
    <<_::bytes-size(index), char::bytes-size(1), _::binary>> = @encoding
    encode_bytes(rest, acc <> char)
  end
  defp encode_bytes(<<>>, acc), do: acc
end
