defmodule Ulid do
  @time_length 10
  @random_length 16

  def generate do
    milliseconds_timestamp = System.system_time(:milli_seconds)

    Ulid.Time.encode(milliseconds_timestamp, @time_length)
      <> Ulid.Random.encode(@random_length)
  end
end
