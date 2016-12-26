defmodule PushApiServer.Push do
  use PushApiServer.Web, :model

  schema "pushes" do
    belongs_to :application, PushApiServer.Application

    field :scheduled_at
    field :request_body, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:application_id, :scheduled_at, :request_body])
    |> validate_required([:application_id, :scheduled_at, :request_body])
  end
end
