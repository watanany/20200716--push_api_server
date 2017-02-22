defmodule PushApiServer.Repo.Migrations.CreatePush do
  use Ecto.Migration

  def change do
    create table(:pushes) do
      add :project_id, references(:projects, on_delete: :delete_all)

      add :request_body, :map, null: false
      add :scheduled_at, :utc_datetime, null: false
      add :sent_at, :utc_datetime

      timestamps()
    end
  end
end
