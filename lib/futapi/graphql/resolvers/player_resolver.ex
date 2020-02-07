defmodule FutApi.GraphQL.PlayerResolver do
  alias FutApi.Fut

  def player_by_id(%{id: id}, _ctx) do
    case Fut.get_player(id) do
      nil -> {:error, "Player not found"}
      player -> {:ok, player}
    end
  end

  def players_list(_args, _ctx) do
    {:ok, Fut.list_players()}
  end
end
