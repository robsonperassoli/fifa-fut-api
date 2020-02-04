defmodule FutApi.Fut do
  alias FutApi.Repo
  alias FutApi.Fut.Player

  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end
end
