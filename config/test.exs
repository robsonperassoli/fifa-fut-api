use Mix.Config

config :futapi, port: 4002

config :futapi, FutApi.Repo,
  database: "futapi_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
