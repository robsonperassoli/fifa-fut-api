defmodule FutApi.Fut.Nation do
  use Ecto.Schema

  schema "nations" do
    field :name, :string
    field :image_url, :string
  end

  def changeset(nation, attrs \\ %{}) do
    nation
    |> Ecto.Changeset.cast(attrs, [:name, :image_url])
    |> Ecto.Changeset.validate_required([:name, :image_url])
  end
end
