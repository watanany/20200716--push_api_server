defmodule PushApiServer.Request do
  use PushApiServer.Web, :model

  schema "requests" do
    field :application_id, :integer
    field :source_ip, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:application_id, :source_ip])
    |> validate_required([:application_id, :source_ip])
  end
end
