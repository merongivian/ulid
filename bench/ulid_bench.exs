defmodule UlidBench do
  use Benchfella

  bench "generate" do
    Ulid.generate()
    nil
  end
end
