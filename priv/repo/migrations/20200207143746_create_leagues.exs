defmodule FutApi.Repo.Migrations.CreateLeagues do
  use Ecto.Migration

  def change do
    create table(:leagues) do
      add :name, :string
      add :image_url, :string
    end
  end
end
