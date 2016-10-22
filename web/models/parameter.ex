defmodule PushApiServer.Parameter do
  use PushApiServer.Web, :model

  schema "parameters" do
    field :key, :string
    field :value, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:key, :value])
    |> validate_required([:key, :value])
  end
end
