defmodule FutApi.Fut.Club do
  use Ecto.Schema
  alias FutApi.Fut.League

  schema "clubs" do
    field :name, :string
    field :image_url, :string
    belongs_to :league, League
  end

  def changeset(club, attrs \\ %{}) do
    club
    |> Ecto.Changeset.cast(attrs, [:name, :image_url, :league_id])
    |> Ecto.Changeset.validate_required([:name, :image_url, :league_id])
  end
end
