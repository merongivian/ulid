defmodule UlidBench do
  use Benchfella

  bench "generate" do
    Ulid.generate()
    nil
  end

  bench "generate_binary" do
    Ulid.generate_binary()
    nil
  end
end
