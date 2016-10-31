defmodule Util do
  def hash(text) do
    :crypto.hash(:sha256, text) |> Base.encode16
  end
end
