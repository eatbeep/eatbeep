defmodule Eatbeep.QR do
  alias Eatbeep.{Tenant, Repo}

  def generate_code(tenant_id) do
    tenant = Repo.get!(Tenant, tenant_id)

  "https://#{tenant.subdomain}.eatbeep.com"
  |> EQRCode.encode()
  |> EQRCode.svg()
  end
end
