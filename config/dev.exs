use Mix.Config

config :futapi, port: 4001

config :futapi, FutApi.Repo,
  database: "futapi_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
