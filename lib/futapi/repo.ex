defmodule FutApi.Repo do
  use Ecto.Repo,
    otp_app: :futapi,
    adapter: Ecto.Adapters.Postgres
end
