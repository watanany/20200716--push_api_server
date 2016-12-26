defmodule PushAPIServer.PushWorker do
  use Application
  use GenServer

  def start(_type, _args) do
    import Supervisor.Spec

    children = [worker(__MODULE__, [])]
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def start_link do
    GenServer.start_link(__MODULE__, HashDict.new, name: __MODULE__)
  end

  def handle_call(_message, _from, _state) do
    :reply
  end

  def handle_cast(_message, _state) do
    :noreply
  end
end
