defmodule FutApi.Application do
  use Application

  def start(_type, _args) do
    children = [
      FutApi.Importer.PlayersQueue,
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: FutApi.Endpoint,
        options: [port: Application.get_env(:futapi, :port)]
      ),
      FutApi.Repo,
      FutApi.Importer,
    ]

    opts = [strategy: :one_for_one, name: FutApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
