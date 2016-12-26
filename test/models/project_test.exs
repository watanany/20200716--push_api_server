defmodule PushAPIServer.ProjectTest do
  use PushAPIServer.ModelCase

  alias PushAPIServer.Project

  @valid_attrs %{name: "some content", server_key: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Project.changeset(%Project{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Project.changeset(%Project{}, @invalid_attrs)
    refute changeset.valid?
  end
end
