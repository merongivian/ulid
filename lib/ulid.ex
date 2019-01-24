defmodule Ulid do
  def generate(timestamp \\ System.system_time(:millisecond)) do
    Ulid.Utils.encode(generate_binary(timestamp))
  end

  def generate_binary(timestamp \\ System.system_time(:millisecond)) do
    <<timestamp::unsigned-size(48), :crypto.strong_rand_bytes(10)::binary>>
  end
end
