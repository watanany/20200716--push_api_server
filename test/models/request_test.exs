defmodule PushApiServer.RequestTest do
  use PushApiServer.ModelCase

  alias PushApiServer.Request

  @valid_attrs %{application_id: 42, source_ip: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Request.changeset(%Request{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Request.changeset(%Request{}, @invalid_attrs)
    refute changeset.valid?
  end
end
