defmodule PushApiServer.Push do
  use PushApiServer.Web, :model

  schema "pushes" do
    belongs_to :application, PushApiServer.Application
    has_many :parameters, PushApiServer.Parameter

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
