defmodule PushAPIServer.Repo.Migrations.CreateApplication do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :project_id, references(:projects, on_delete: :delete_all)
      add :name, :string, null: false

      timestamps()
    end

    create index(:applications, :name)
  end
end
