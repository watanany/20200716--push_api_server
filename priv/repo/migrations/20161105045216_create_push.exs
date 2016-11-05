defmodule PushApiServer.Repo.Migrations.CreatePush do
  use Ecto.Migration

  def change do
    create table(:pushes) do

      timestamps()
    end

  end
end
