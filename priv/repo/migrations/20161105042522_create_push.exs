defmodule PushApiServer.Repo.Migrations.CreatePush do
  use Ecto.Migration

  def change do
    create table(:pushes) do
      add :application_id, references(:applications, on_delete: :delete_all)

      timestamps()
    end
  end
end
