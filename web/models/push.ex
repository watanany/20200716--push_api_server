defmodule PushApiServer.Push do
  use PushApiServer.Web, :model

  schema "pushes" do
    belongs_to :application, PushApiServer.Application

    field :scheduled_at

    # Request parameters
    field :to, :string
    field :registration_ids, {:array, :string}
    field :condition, :string
    field :collapse_key, :string
    field :priority, :string
    field :content_available, :boolean
    field :deley_while_idle, :boolean
    field :time_to_live, :integer
    field :restricted_package_name, :string
    field :dry_run, :boolean
    field :data, :map
    embeds_one :notification, Notification

    # Response columns
    field :multicast_id, :integer
    field :success, :integer
    field :failure, :integer
    field :canonical_ids, :integer
    embeds_many :results, Result

    field :message_id, :integer
    field :error, :string

    field :id_, :integer

    field :Error, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:application_id])
    |> validate_required([:application_id])
  end
end
