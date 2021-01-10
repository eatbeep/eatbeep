defmodule Eatbeep.Plug.TenantLookup do
  import Plug.Conn
  alias Eatbeep.Tenant
  use EatbeepWeb, :controller

  def init(opts), do: opts

  def call(%{host: host} = conn, _opts) do
    subdomain = host |> String.split(".") |> Enum.at(0)

    case Tenant.get_by_subdomain(subdomain) do
      %Tenant{} = tenant ->
        conn
        |> put_session(:tenant_id, tenant.id)
      nil ->
        conn |> put_status(:not_found) |> text("Not found") |> halt()
    end
  end


end
