defmodule PushApiServer.Repo.Migrations.CreateParameter do
  use Ecto.Migration

  def change do
    create table(:parameters) do
      add :request_id, references(:requests)
      add :key, :string
      add :value, :string

      timestamps()
    end
  end
end
