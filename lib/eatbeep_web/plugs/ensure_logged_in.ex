defmodule Eatbeep.Plug.EnsureLoggedIn do
  import Plug.Conn
  use EatbeepWeb, :controller

  def init(opts), do: opts

  def call(conn, _opts) do
    if get_session(conn, :logged_in?) do
      conn
    else
      conn
       |> put_flash(:error, "You must log in to access this page.")
       |> redirect(to: Routes.login_path(conn, :index))
       |> halt()
    end
  end
end
