defmodule PushApiServer.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :user_id, references(:users)
      add :name, :string
      add :server_key, :string

      timestamps()
    end

    create index(:projects, :name)
    create unique_index(:server_key)
  end
end
