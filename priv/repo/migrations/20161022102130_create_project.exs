defmodule PushAPIServer.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :name, :string, null: false
      add :server_key, :string, null: false

      timestamps()
    end

    create index(:projects, :name)
    create unique_index(:projects, :server_key)
  end
end
