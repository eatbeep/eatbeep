# From https://github.com/aaronrenner/phx_gen_auth_output/blob/6a2d9e223ec1d90d6d6b79103f5d07944f4b2993/lib/demo_web/controllers/user_auth.ex
defmodule Eatbeep.Plug.Login do
  import Plug.Conn
  alias Eatbeep.Login
  use EatbeepWeb, :controller

  def init(opts), do: opts

  def call(%{query_params: %{"ott" => token}} = conn, _opts) do
    tenant_id = get_session(conn, "tenant_id")

    case Login.exchange_login_token(token, tenant_id) do
      {:ok, _session_token} ->
        conn
        |> renew_session()
        |> put_session(:logged_in?, true)
        |> put_session(:live_socket_id, "users_sessions:#{Base.url_encode64(token)}")
        |> redirect(to: "/menu")
      _ ->
        conn |> put_status(:bad_request) |> text("Unable to complete login") |> halt()
    end

  end

  def call(conn, _) do
    conn
  end

  defp renew_session(conn) do
    conn
    |> configure_session(renew: true)
    |> clear_session()
  end
end
