defmodule PushApiServer.PushController do
  use PushApiServer.Web, :controller

  alias PushApiServer.Push

  def index(conn, _params) do
    pushes = Repo.all(Push)
    render(conn, "index.html", pushes: pushes)
  end

  def show(conn, %{"id" => id}) do
    push = Repo.get!(Push, id)
    render(conn, "show.html", push: push)
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
