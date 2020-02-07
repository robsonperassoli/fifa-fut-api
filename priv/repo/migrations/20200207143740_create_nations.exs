defmodule FutApi.Repo.Migrations.CreateNations do
  use Ecto.Migration

  def change do
    create table(:nations) do
      add :name, :string
      add :image_url, :string
    end
  end
end
