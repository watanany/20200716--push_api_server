defmodule PushAPIServer.ApplicationController do
  use PushAPIServer.Web, :controller

  alias PushAPIServer.Application

  def index(conn, _params) do
    applications = Repo.all(Application)
    render(conn, "index.html", applications: applications)
  end

  def new(conn, _params) do
    changeset = Application.changeset(%Application{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"application" => application_params}) do
    changeset = Application.changeset(%Application{}, application_params)

    case Repo.insert(changeset) do
      {:ok, _application} ->
        conn
        |> put_flash(:info, "Application created successfully.")
        |> redirect(to: application_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    application = Repo.get!(Application, id)
    render(conn, "show.html", application: application)
  end

  def edit(conn, %{"id" => id}) do
    application = Repo.get!(Application, id)
    changeset = Application.changeset(application)
    render(conn, "edit.html", application: application, changeset: changeset)
  end

  def update(conn, %{"id" => id, "application" => application_params}) do
    application = Repo.get!(Application, id)
    changeset = Application.changeset(application, application_params)

    case Repo.update(changeset) do
      {:ok, application} ->
        conn
        |> put_flash(:info, "Application updated successfully.")
        |> redirect(to: application_path(conn, :show, application))
      {:error, changeset} ->
        render(conn, "edit.html", application: application, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    application = Repo.get!(Application, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(application)

    conn
    |> put_flash(:info, "Application deleted successfully.")
    |> redirect(to: application_path(conn, :index))
  end
end
