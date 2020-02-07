defmodule FutApi.Fut.Player do
  use Ecto.Schema
  alias FutApi.Fut.{Club, Nation}

  schema "players" do
    field :name, :string
    field :rating, :integer
    belongs_to :club, Club
    belongs_to :nation, Nation
  end

  def changeset(player, params \\ %{}) do
    player
    |> Ecto.Changeset.cast(params, [:id, :name, :rating, :club_id, :nation_id])
    |> Ecto.Changeset.validate_required([:id, :name, :rating, :club_id, :nation_id])
  end
end
