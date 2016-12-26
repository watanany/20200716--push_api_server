defmodule PushAPIServer.PushTest do
  use PushAPIServer.ModelCase

  alias PushAPIServer.Push

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Push.changeset(%Push{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Push.changeset(%Push{}, @invalid_attrs)
    refute changeset.valid?
  end
end
