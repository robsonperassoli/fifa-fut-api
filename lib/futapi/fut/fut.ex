defmodule FutApi.Fut do
  alias FutApi.Repo
  alias FutApi.Fut.Player

  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  def update_player(%Player{} = player, %{} = attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  def integrate_player(%{id: id} = attrs) do
    case get_player(id) do
      nil -> create_player(attrs)
      %Player{} = player -> update_player(player, attrs)
    end
  end

  def get_player!(id), do: Repo.get!(Player, id)
  def get_player(id), do: Repo.get(Player, id)
end
