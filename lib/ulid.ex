defmodule Ulid do
  @type t :: binary()

  @spec generate(pos_integer()) :: t()
  def generate(timestamp \\ System.system_time(:millisecond)) do
    Ulid.Utils.encode(generate_binary(timestamp))
  end

  @spec generate_binary(pos_integer()) :: t()
  def generate_binary(timestamp \\ System.system_time(:millisecond)) do
    <<timestamp::unsigned-size(48), :crypto.strong_rand_bytes(10)::binary>>
  end
end
