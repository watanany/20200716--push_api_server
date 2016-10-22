defmodule PushApiServer.Repo.Migrations.CreateApplication do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :project_id, references(:projects)
      add :name, :string

      timestamps()
    end

    create index(:applications, :name)
  end
end
