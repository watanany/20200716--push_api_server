defmodule PushAPIServer.API.PushView do
  use PushAPIServer.Web, :view

  def render("index.json", %{pushes: pushes}) do
    %{data: render_many(pushes, PushAPIServer.API.PushView, "push.json")}
  end

  def render("show.json", %{push: push}) do
    %{data: render_one(push, PushAPIServer.API.PushView, "push.json")}
  end

  def render("push.json", %{push: push}) do
    %{id: push.id}
  end
end
