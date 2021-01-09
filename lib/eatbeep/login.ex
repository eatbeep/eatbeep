defmodule Eatbeep.Login do
  alias Eatbeep.{Repo, Tenant}

  def login(tenant_id, %Ecto.Changeset{changes: %{email: email, password: password}}) do
    tenant = Repo.get_by(Tenant, %{email: email, id: tenant_id})

    case Bcrypt.check_pass(tenant, password, hash_key: :hashed_password) do
      {:ok, tenant} ->
        {:ok, generate_login_token(tenant)}
      {:error, _} -> {:error, "Invalid username or password"}
    end

  end

  defp generate_login_token(tenant) do
    Phoenix.Token.sign(EatbeepWeb.Endpoint, "login", tenant.id, max_age: 30)
  end

  def exchange_login_token(token) do
    case Phoenix.Token.verify(EatbeepWeb.Endpoint, "login", token, max_age: 30) do
      {:ok, tenant_id} ->
        Phoenix.Token.sign(EatbeepWeb.Endpoint, "session", tenant_id, max_age: 86400)
      {:error, _} -> {:error, "Invalid token"}
    end
  end

  def verify_session_token(token) do
    Phoenix.Token.verify(EatbeepWeb.Endpoint, "session", token, max_age: 86400)
  end

end
