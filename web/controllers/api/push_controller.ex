defmodule PushAPIServer.API.PushController do
  use PushAPIServer.Web, :controller

  alias PushAPIServer.Push

  def index(conn, %{"server_key" => server_key}) do
    project = Repo.get_by!(Project, server_key: server_key)
    pushes = Repo.all(Push, project_id: project.id)
    render(conn, "index.json", pushes: pushes)
  end

  def create(conn, %{"push" => push_params, "server_key" => server_key}) do
    project = Repo.get_by!(Project, server_key: server_key)
    push_params = Map.put(push_params, "project_id", project.id)
    changeset = Push.changeset(%Push{}, push_params)

    case Repo.insert(changeset) do
      {:ok, push} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", push_path(conn, :show, push))
        |> render("show.json", push: push)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PushAPIServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "server_key" => server_key}) do
    project = Repo.get_by!(Project, server_key: server_key)
    push = Repo.get_by!(Push, id: id, project_id: project.id)
    render(conn, "show.json", push: push)
  end

  def update(conn, %{"id" => id, "push" => push_params, "server_key" => server_key}) do
    project = Repo.get_by!(Project, server_key: server_key)
    push = Repo.get_by!(Push, id: id, project_id: project.id)
    changeset = Push.changeset(push, push_params)

    case Repo.update(changeset) do
      {:ok, push} ->
        render(conn, "show.json", push: push)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PushAPIServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "server_key" => server_key}) do
    project = Repo.get_by!(Project, server_key: server_key)
    push = Repo.get_by!(Push, id: id, project_id: project.id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(push)

    send_resp(conn, :no_content, "")
  end
end
