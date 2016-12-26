defmodule PushAPIServer.PushController do
  use PushAPIServer.Web, :controller

  alias PushAPIServer.Push

  def index(conn, _params) do
    pushes = Repo.all(Push)
    render(conn, "index.html", pushes: pushes)
  end

  def new(conn, _params) do
    changeset = Push.changeset(%Push{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"push" => push_params}) do
    changeset = Push.changeset(%Push{}, push_params)

    case Repo.insert(changeset) do
      {:ok, _push} ->
        conn
        |> put_flash(:info, "Push created successfully.")
        |> redirect(to: push_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    push = Repo.get!(Push, id)
    render(conn, "show.html", push: push)
  end

  def edit(conn, %{"id" => id}) do
    push = Repo.get!(Push, id)
    changeset = Push.changeset(push)
    render(conn, "edit.html", push: push, changeset: changeset)
  end

  def update(conn, %{"id" => id, "push" => push_params}) do
    push = Repo.get!(Push, id)
    changeset = Push.changeset(push, push_params)

    case Repo.update(changeset) do
      {:ok, push} ->
        conn
        |> put_flash(:info, "Push updated successfully.")
        |> redirect(to: push_path(conn, :show, push))
      {:error, changeset} ->
        render(conn, "edit.html", push: push, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    push = Repo.get!(Push, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(push)

    conn
    |> put_flash(:info, "Push deleted successfully.")
    |> redirect(to: push_path(conn, :index))
  end
end
