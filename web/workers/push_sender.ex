defmodule PushApiServer.Workers.PushSender do
  use GenServer

  require Ecto
  require Ecto.Query
  import Ecto.Query, only: [from: 2]

  alias PushApiServer.Repo
  alias PushApiServer.Push

  @interval 60_000

  #======================================================================
  # GenServer Callbacks
  #======================================================================
  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    {:ok, perform()}
  end

  def handle_info(:perform, _state) do
    {:noreply, perform()}
  end

  #======================================================================
  # Private Functions
  #======================================================================
  defp perform do
    #pushes = from(p in Push, where: p.scheduled_at > ^Ecto.DateTime.utc)
    #         |> Repo.all
    #         |> Repo.preload(:project)
    #
    #pushes |> Enum.each(fn (push) ->
    #  FCM.push(push.project.server_key, push.request_body)
    #end)
    Process.send_after(self(), :perform, @interval)
    []
  end
end
