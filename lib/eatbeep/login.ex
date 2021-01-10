defmodule Eatbeep.Login do
  alias Eatbeep.{Repo, Tenant}

  def login(tenant_id, %Ecto.Changeset{changes: %{email: email, password: password}}) do
    tenant = Repo.get_by(Tenant, %{email: email, id: tenant_id})

    case Bcrypt.check_pass(tenant, password, hash_key: :hashed_password) do
      {:ok, tenant} ->
        generate_login_token(tenant)
      {:error, _} -> {:error, "Invalid username or password"}
    end

  end

  def generate_login_token(tenant) do
    {:ok, Phoenix.Token.sign(EatbeepWeb.Endpoint, "login", tenant.id, max_age: 30)}
  end

  def exchange_login_token(token, current_tenant_id) do
    with {:ok, tenant_id} <- Phoenix.Token.verify(EatbeepWeb.Endpoint, "login", token, max_age: 30),
      :ok <- tenant_match?(tenant_id, current_tenant_id)
    do
      {:ok, Phoenix.Token.sign(EatbeepWeb.Endpoint, "session", tenant_id, max_age: 86400)}
    else
      {:error, _} -> {:error, "Invalid token"}
    end
  end

  def tenant_match?(val, val), do: :ok
  def tenant_match?(_, _), do: {:error, ""}

  def verify_session_token(token) do
    Phoenix.Token.verify(EatbeepWeb.Endpoint, "session", token, max_age: 86400)
  end

end
