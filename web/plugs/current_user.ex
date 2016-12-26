defmodule PushApiServer.Plugs.CurrentUser do
  import Plug.Conn
  require Ecto
  require Ecto.Query
  alias PushApiServer.Repo
  alias PushApiServer.User

  defmacro __using__(_) do
    quote do
      plug PushApiServer.Plugs.CurrentUser

      defmacro current_user do
        quote do
          var!(conn).assigns[:current_user]
        end
      end
    end
  end

  def init(default) do
    default
  end

  def call(conn, _) do
    current_user_id = get_session(conn, :current_user_id)
    current_user =
      if current_user_id do
        User
        |> Ecto.Query.where(id: ^current_user_id)
        |> Repo.one
        |> Repo.preload(projects: [applications: [pushes: :parameters]])
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
