defmodule Housekeeper.Application do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Housekeeper.Endpoint,
        options: [port: Application.get_env(:housekeeper, :port)]
      )
    ]

    opts = [strategy: :one_for_one, name: Housekeeper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
