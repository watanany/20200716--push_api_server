defmodule PushApiServer.Repo.Migrations.CreatePush do
  use Ecto.Migration

  def change do
    create table(:pushes) do
      add :application_id, references(:applications, on_delete: :delete_all)

      add :scheduled_at, :datetime, null: false

      # Request parameters
      add :to, :string
      add :registration_ids, {:array, :string}
      add :condition, :string
      add :collapse_key, :string
      add :priority, :string
      add :content_available, :boolean
      add :deley_while_idle, :boolean
      add :time_to_live, :integer
      add :restricted_package_name, :string
      add :dry_run, :boolean
      add :data, :json
      add :notification, :map

      add :registration_id, :integer

      # Response columns
      add :multicast_id, :integer
      add :success, :integer
      add :failure, :integer
      add :canonical_ids, :integer
      add :results, {:array, :map}

      add :message_id, :integer
      add :error, :string

      add :id_, :integer

      add :Error, :string

      timestamps()
    end
  end
end
