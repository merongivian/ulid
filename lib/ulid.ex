defmodule Ulid do
  @time_length 10
  @random_length 16

  def generate(timestamp \\ System.system_time(:milli_seconds)) do
    Ulid.Utils.encode(generate_binary(timestamp))
  end

  def generate_binary(timestamp \\ System.system_time(:milli_seconds)) do
    <<timestamp::unsigned-size(48), :crypto.strong_rand_bytes(10)::binary>>
  end
end
