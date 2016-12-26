defmodule PushAPIServer.Repo.Migrations.CreatePush do
  use Ecto.Migration

  def change do
    create table(:pushes) do
      add :application_id, references(:applications, on_delete: :delete_all)

      add :scheduled_at, :datetime, null: false
      add :request_body, :map, null: false

      timestamps()
    end
  end
end
