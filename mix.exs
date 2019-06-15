defmodule Housekeeper.MixProject do
  use Mix.Project

  def project do
    [
      app: :housekeeper,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {Housekeeper.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.1.2"},
      {:absinthe, "~> 1.4.6"},
      {:absinthe_plug, "~> 1.4.7"}
    ]
  end
end
