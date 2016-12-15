defmodule Notification do
  use PushApiServer.Web, :model

  embedded_schema do
    field :title, :string
    field :body, :string
    field :icon, :string
    field :sound, :string
    field :badge, :string
    field :tag, :string
    field :color, :string
    field :click_action, :string
    field :body_loc_key, :string
    field :body_loc_args, {:array, :string}
    field :title_loc_key, :string
    field :title_loc_args, {:array, :string}
  end
end
