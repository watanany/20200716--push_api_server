defmodule PushAPIServer.User do
  use PushAPIServer.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :encrypted_password, :string

    has_many :projects, PushAPIServer.Project

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password, :password_confirmation, :encrypted_password])
    |> validate_required([:email, :password, :password_confirmation, :encrypted_password])
    |> unique_constraint(:email)
    |> validate_confirmation(:password)
  end
end
