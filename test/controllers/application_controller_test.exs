defmodule PushAPIServer.ApplicationControllerTest do
  use PushAPIServer.ConnCase

  alias PushAPIServer.Application
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, application_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing applications"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, application_path(conn, :new)
    assert html_response(conn, 200) =~ "New application"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, application_path(conn, :create), application: @valid_attrs
    assert redirected_to(conn) == application_path(conn, :index)
    assert Repo.get_by(Application, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, application_path(conn, :create), application: @invalid_attrs
    assert html_response(conn, 200) =~ "New application"
  end

  test "shows chosen resource", %{conn: conn} do
    application = Repo.insert! %Application{}
    conn = get conn, application_path(conn, :show, application)
    assert html_response(conn, 200) =~ "Show application"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, application_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    application = Repo.insert! %Application{}
    conn = get conn, application_path(conn, :edit, application)
    assert html_response(conn, 200) =~ "Edit application"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    application = Repo.insert! %Application{}
    conn = put conn, application_path(conn, :update, application), application: @valid_attrs
    assert redirected_to(conn) == application_path(conn, :show, application)
    assert Repo.get_by(Application, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    application = Repo.insert! %Application{}
    conn = put conn, application_path(conn, :update, application), application: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit application"
  end

  test "deletes chosen resource", %{conn: conn} do
    application = Repo.insert! %Application{}
    conn = delete conn, application_path(conn, :delete, application)
    assert redirected_to(conn) == application_path(conn, :index)
    refute Repo.get(Application, application.id)
  end
end
