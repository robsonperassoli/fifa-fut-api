defmodule FutApi.DataImporter do
  alias FutApi.Fifa
  alias FutApi.Repo
  alias FutApi.Player

  def fetch do
    {:ok, response} = Fifa.get_players()
    %{body: body} = response
    %{"items" => items} = body
    items
  end

  def save(%{"name" => name, "rating" => rating}) do
    Player.changeset(%Player{}, %{name: name, rating: rating})
    |> Repo.insert
  end

  def import_players do
    fetch()
    |> Enum.map(&FutApi.DataImporter.save/1)
  end
end
