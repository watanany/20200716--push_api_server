defmodule PushApiServer.Repo.Migrations.CreateParameter do
  use Ecto.Migration

  def change do
    create table(:parameters) do
      add :request_id, references(:requests, on_delete: :delete_all)
      add :key, :string, null: false
      add :value, :string, null: false

      timestamps()
    end

    create index(:parameters, [:key, :value])
  end
end
