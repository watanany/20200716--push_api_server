defmodule PushApiServer.Plugs.CurrentUser do
  import Plug.Conn
  require Ecto
  require Ecto.Query
  alias PushApiServer.Repo
  alias PushApiServer.User

  def init(default), do: default

  def call(conn, _) do
    user_id = get_session(conn, :current_user)
    current_user =
      if user_id do
        User |> Ecto.Query.where(id: ^user_id) |> Repo.one
      else
        nil
      end

    case current_user do
      %User{} ->
        conn |> assign(:current_user, current_user)
      nil ->
        url = PushApiServer.Router.Helpers.signin_path(conn, :new, refer: conn.request_path)
        conn
        |> Phoenix.Controller.redirect(to: url)
        |> halt
    end
  end
end
