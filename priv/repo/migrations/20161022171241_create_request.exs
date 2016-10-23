defmodule PushApiServer.Repo.Migrations.CreateRequest do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :application_id, references(:applications, on_delete: :delete_all)
      add :source_ip, :string, null: false

      timestamps()
    end

  end
end
