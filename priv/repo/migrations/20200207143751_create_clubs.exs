defmodule FutApi.Repo.Migrations.CreateClubs do
  use Ecto.Migration

  def change do
    create table(:clubs) do
      add :name, :string
      add :image_url, :string
      add :league_id, references(:leagues)
    end
  end
end
