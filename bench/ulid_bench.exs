Benchee.run(
  %{
    "generate" => fn -> Ulid.generate() end,
    "generate_binary" => fn -> Ulid.generate_binary() end
  }
)
