defmodule FutApi.Repo.Migrations.AddClubToPlayer do
  use Ecto.Migration

  def change do
    alter table(:players) do
      add :club_id, references(:clubs)
    end
  end
end
