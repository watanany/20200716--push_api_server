defmodule PushAPIServer.PushControllerTest do
  use PushAPIServer.ConnCase

  alias PushAPIServer.Push
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, push_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing pushes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, push_path(conn, :new)
    assert html_response(conn, 200) =~ "New push"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, push_path(conn, :create), push: @valid_attrs
    assert redirected_to(conn) == push_path(conn, :index)
    assert Repo.get_by(Push, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, push_path(conn, :create), push: @invalid_attrs
    assert html_response(conn, 200) =~ "New push"
  end

  test "shows chosen resource", %{conn: conn} do
    push = Repo.insert! %Push{}
    conn = get conn, push_path(conn, :show, push)
    assert html_response(conn, 200) =~ "Show push"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, push_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    push = Repo.insert! %Push{}
    conn = get conn, push_path(conn, :edit, push)
    assert html_response(conn, 200) =~ "Edit push"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    push = Repo.insert! %Push{}
    conn = put conn, push_path(conn, :update, push), push: @valid_attrs
    assert redirected_to(conn) == push_path(conn, :show, push)
    assert Repo.get_by(Push, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    push = Repo.insert! %Push{}
    conn = put conn, push_path(conn, :update, push), push: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit push"
  end

  test "deletes chosen resource", %{conn: conn} do
    push = Repo.insert! %Push{}
    conn = delete conn, push_path(conn, :delete, push)
    assert redirected_to(conn) == push_path(conn, :index)
    refute Repo.get(Push, push.id)
  end
end
