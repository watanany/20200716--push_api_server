defmodule PushApiServer.Application do
  use PushApiServer.Web, :model

  schema "applications" do
    field :name, :string

    belongs_to :project, PushApiServer.Project
    has_many :pushes, PushApiServer.Push

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
