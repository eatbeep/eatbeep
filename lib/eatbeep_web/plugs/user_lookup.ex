defmodule Eatbeep.Plug.UserLookup do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # IO.inspect(conn.headers, label: "headers")

    conn
    # |> put_session("user_id", "123")
    # |> put_session("tenant_id", "456")
    # |> put_session("role", "user")
    |> put_session("logged_in?", false)

    # include actor as well
  end
end
