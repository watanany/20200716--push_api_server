defmodule PushApiServer.SessionController do
  use PushApiServer.Web, :controller

  alias PushApiServer.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    email = user_params.email
    encrypted_password = Util.hash(user_params.password)

    user = User
    |> Ecto.Query.where(email: ^email, encrypted_password: ^encrypted_password)
    |> Repo.one

    case user do
      %User{} ->
        conn
        |> put_session(:current_user, user.id)
        |> redirect(to: root_path(conn, :index))
      nil ->
        conn
        |> redirect(to: "/signin")
    end
  end

  def delete(conn, %{"id" => id}) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: root_path(conn, :index))
  end
end
