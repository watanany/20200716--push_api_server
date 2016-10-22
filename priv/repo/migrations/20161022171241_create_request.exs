defmodule PushApiServer.Repo.Migrations.CreateRequest do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :application_id, references(:applications)
      add :source_ip, :string

      timestamps()
    end

  end
end
