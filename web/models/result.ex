defmodule Result do
  use PushApiServer.Web, :model

  embedded_schema do
    field :message_id, :string
    field :registration_id, :string
    field :error, :string
  end
end
