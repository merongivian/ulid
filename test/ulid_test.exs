defmodule UlidTest do
  use ExUnit.Case, async: true

  test "generates 26 characters" do
    assert String.length(Ulid.generate) == 26
  end

  test "is sortable" do
    ulid1 = Ulid.generate()
    Process.sleep(1)
    ulid2 = Ulid.generate()

    assert ulid2 > ulid1
  end

  test "decode time" do
    current_time = System.system_time(:milli_seconds)

    decoded_time = Ulid.Utils.decode_time(Ulid.generate(current_time));

    assert decoded_time == current_time
  end
end
