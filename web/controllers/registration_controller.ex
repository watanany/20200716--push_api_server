defmodule PushApiServer.RegistrationController do
  use PushApiServer.Web, :controller

  alias PushApiServer.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "encrypted_password", Util.hash(user_params["password"]))
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:current_user, user.id)
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        conn |> redirect(to: "/signup")
    end
  end
end
