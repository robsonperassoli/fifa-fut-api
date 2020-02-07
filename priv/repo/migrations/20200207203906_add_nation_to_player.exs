defmodule FutApi.Repo.Migrations.AddNationToPlayer do
  use Ecto.Migration

  def change do
    alter table("players") do
      add :nation_id, references("nations")
    end
  end
end
