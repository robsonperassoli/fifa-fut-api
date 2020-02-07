defmodule FutApi.Fut.Player do
  use Ecto.Schema
  alias FutApi.Fut.Club

  schema "players" do
    field :name, :string
    field :rating, :integer
    belongs_to :club, Club
  end

  def changeset(player, params \\ %{}) do
    player
    |> Ecto.Changeset.cast(params, [:id, :name, :rating, :club_id])
    |> Ecto.Changeset.validate_required([:id, :name, :rating, :club_id])
  end
end
