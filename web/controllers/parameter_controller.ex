defmodule PushApiServer.ParameterController do
  use PushApiServer.Web, :controller

  alias PushApiServer.Parameter

  def index(conn, _params) do
    parameters = Repo.all(Parameter)
    render(conn, "index.html", parameters: parameters)
  end

  def new(conn, _params) do
    changeset = Parameter.changeset(%Parameter{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"parameter" => parameter_params}) do
    changeset = Parameter.changeset(%Parameter{}, parameter_params)

    case Repo.insert(changeset) do
      {:ok, _parameter} ->
        conn
        |> put_flash(:info, "Parameter created successfully.")
        |> redirect(to: parameter_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    parameter = Repo.get!(Parameter, id)
    render(conn, "show.html", parameter: parameter)
  end

  def edit(conn, %{"id" => id}) do
    parameter = Repo.get!(Parameter, id)
    changeset = Parameter.changeset(parameter)
    render(conn, "edit.html", parameter: parameter, changeset: changeset)
  end

  def update(conn, %{"id" => id, "parameter" => parameter_params}) do
    parameter = Repo.get!(Parameter, id)
    changeset = Parameter.changeset(parameter, parameter_params)

    case Repo.update(changeset) do
      {:ok, parameter} ->
        conn
        |> put_flash(:info, "Parameter updated successfully.")
        |> redirect(to: parameter_path(conn, :show, parameter))
      {:error, changeset} ->
        render(conn, "edit.html", parameter: parameter, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    parameter = Repo.get!(Parameter, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(parameter)

    conn
    |> put_flash(:info, "Parameter deleted successfully.")
    |> redirect(to: parameter_path(conn, :index))
  end
end
