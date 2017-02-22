defmodule PushApiServer.Push do
  use PushApiServer.Web, :model

  schema "pushes" do
    belongs_to :project, PushApiServer.Project

    field :request_body, :map
    field :scheduled_at, Ecto.DateTime
    field :sent_at, Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    request_body = Poison.decode!(params["request_body"])
    scheduled_at = Ecto.DateTime.cast!(params["scheduled_at"])
    struct
    |> cast(params, [:project_id, :request_body, :scheduled_at, :sent_at])
    |> validate_required([:project_id, :request_body, :scheduled_at])
    |> put_change(:request_body, request_body)
    |> put_change(:scheduled_at, scheduled_at)
  end
end
