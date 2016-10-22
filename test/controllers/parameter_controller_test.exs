defmodule PushApiServer.ParameterControllerTest do
  use PushApiServer.ConnCase

  alias PushApiServer.Parameter
  @valid_attrs %{key: "some content", value: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, parameter_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing parameters"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, parameter_path(conn, :new)
    assert html_response(conn, 200) =~ "New parameter"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, parameter_path(conn, :create), parameter: @valid_attrs
    assert redirected_to(conn) == parameter_path(conn, :index)
    assert Repo.get_by(Parameter, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, parameter_path(conn, :create), parameter: @invalid_attrs
    assert html_response(conn, 200) =~ "New parameter"
  end

  test "shows chosen resource", %{conn: conn} do
    parameter = Repo.insert! %Parameter{}
    conn = get conn, parameter_path(conn, :show, parameter)
    assert html_response(conn, 200) =~ "Show parameter"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, parameter_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    parameter = Repo.insert! %Parameter{}
    conn = get conn, parameter_path(conn, :edit, parameter)
    assert html_response(conn, 200) =~ "Edit parameter"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    parameter = Repo.insert! %Parameter{}
    conn = put conn, parameter_path(conn, :update, parameter), parameter: @valid_attrs
    assert redirected_to(conn) == parameter_path(conn, :show, parameter)
    assert Repo.get_by(Parameter, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    parameter = Repo.insert! %Parameter{}
    conn = put conn, parameter_path(conn, :update, parameter), parameter: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit parameter"
  end

  test "deletes chosen resource", %{conn: conn} do
    parameter = Repo.insert! %Parameter{}
    conn = delete conn, parameter_path(conn, :delete, parameter)
    assert redirected_to(conn) == parameter_path(conn, :index)
    refute Repo.get(Parameter, parameter.id)
  end
end
