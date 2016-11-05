defmodule PushApiServer.Parameter do
  use PushApiServer.Web, :model

  schema "parameters" do
    field :key, :string
    field :value, :string

    belongs_to :push, PushApiServer.Push

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:push_id, :key, :value])
    |> validate_required([:push_id, :key, :value])
  end
end
