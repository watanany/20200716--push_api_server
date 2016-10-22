defmodule PushApiServer.ParameterTest do
  use PushApiServer.ModelCase

  alias PushApiServer.Parameter

  @valid_attrs %{key: "some content", value: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Parameter.changeset(%Parameter{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Parameter.changeset(%Parameter{}, @invalid_attrs)
    refute changeset.valid?
  end
end
