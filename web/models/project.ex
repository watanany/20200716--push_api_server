defmodule PushAPIServer.Project do
  use PushAPIServer.Web, :model

  schema "projects" do
    field :name, :string
    field :server_key, :string

    belongs_to :user, PushAPIServer.User
    has_many :applications, PushAPIServer.Application

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
