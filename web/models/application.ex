defmodule PushApiServer.Application do
  use PushApiServer.Web, :model

  schema "applications" do
    field :project_id, :integer
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:project_id, :name])
    |> validate_required([:project_id, :name])
  end
end
