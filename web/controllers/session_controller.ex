defmodule PushApiServer.SessionController do
  use PushApiServer.Web, :controller

  alias PushApiServer.User

  def new(conn, params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset, refer: params["refer"])
  end

  def create(conn, params = %{"user" => user_params}) do
    email = Map.get(user_params, :email)
    password = Map.get(user_params, :password)
    encrypted_password = if password, do: Util.hash(password), else: nil
    refer = params["refer"]

    user =
      if email && encrypted_password do
        User
        |> Ecto.Query.where(email: ^email, encrypted_password: ^encrypted_password)
        |> Repo.one
      else
        nil
      end

    case user do
      %User{} ->
        conn
        |> put_session(:current_user, user.id)
        |> redirect(to: refer)
      nil ->
        new_params = if refer != "", do: %{"refer" => refer}, else: %{}
        conn
        |> redirect(to: signin_path(conn, :new, new_params))
    end
  end

  def delete(conn, %{"id" => id}) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: root_path(conn, :index))
  end
end
