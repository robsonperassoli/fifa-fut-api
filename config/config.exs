# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config


config :futapi,
  ecto_repos: [FutApi.Repo]

import_config "#{Mix.env()}.exs"
