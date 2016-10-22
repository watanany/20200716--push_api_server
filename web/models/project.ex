defmodule PushApiServer.Project do
  use PushApiServer.Web, :model

  schema "projects" do
    field :user_id, :integer
    field :name, :string
    field :server_key, :string

    has_many :applications, Application

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :name, :server_key])
    |> validate_required([:user_id, :name, :server_key])
  end
end
