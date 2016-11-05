defmodule PushApiServer.Repo.Migrations.CreateParameter do
  use Ecto.Migration

  def change do
    create table(:parameters) do
      add :push_id, references(:pushes, on_delete: :delete_all)
      add :key, :string, null: false
      add :value, :string, null: false

      timestamps()
    end

    create index(:parameters, [:key, :value])
  end
end
