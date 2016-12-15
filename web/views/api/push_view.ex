defmodule PushApiServer.Api.PushView do
  use PushApiServer.Web, :view

  def render("index.json", %{pushes: pushes}) do
    %{data: render_many(pushes, PushApiServer.Api.PushView, "push.json")}
  end

  def render("show.json", %{push: push}) do
    %{data: render_one(push, PushApiServer.Api.PushView, "push.json")}
  end

  def render("push.json", %{push: push}) do
    %{id: push.id}
  end
end
