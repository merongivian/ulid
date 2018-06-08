defmodule Ulid.Utils do
  @encoding "0123456789ABCDEFGHJKMNPQRSTVWXYZ"

  def encode(<<_::unsigned-size(128)>> = bytes), do: encode_bytes(<<0::2, bytes::binary>>, <<>>)

  defp encode_bytes(<<index::unsigned-size(5), rest::bitstring>>, acc) do
    <<_::bytes-size(index), char::bytes-size(1), _::binary>> = @encoding
    encode_bytes(rest, acc <> char)
  end
  defp encode_bytes(<<>>, acc), do: acc 

  @doc """
  Takes a ulid string and returns the timestamp in millisecs.
  """
  def decode_time(<<time::binary-size(10), _::binary-size(16)>> = _ulid) do
    decode_bytes(<<time::binary>>, <<>>) |> bitstring_to_int(50)
  end

  defp decode_bytes(<<index::unsigned-size(8), rest::bitstring>>, acc) do
    # convert index into base32 value.  Assumes only uppercase chars in Ulid.
    # test which char range the index is in and subtract accordingly (excludes chars I,L,O,U).
    value = cond do
      index < 58 -> index-48 # 0-9
      index < 73 -> index-55 # A-H
      index < 76 -> index-56 # J-K
      index < 79 -> index-57 # M-N
      index < 85 -> index-58 # P-T
      true -> index-59 # index <= 90 # V-Z
    end

    decode_bytes(rest, <<acc::bitstring, value::unsigned-size(5)>> )
  end

  defp decode_bytes(<<>>, acc), do: acc

  defp bitstring_to_int(base32_vals, len) do
    hd(for <<acc::size(len) <- base32_vals>>, do: acc)
  end
end
