defmodule Eatbeep.Signup do
  alias Eatbeep.Api
  alias Eatbeep.{Tenant, User, Role}
  alias Ecto.Multi

  defp create_user(user, tenant) do
    Ash.Changeset.new(User, user)
    |> Ash.Changeset.replace_relationship(:tenants, [{tenant.id, %{role: "owner"}}])
    |> Api.create(action: :signup)
  end

  defp create_tenant(tenant) do
    Ash.Changeset.new(Tenant, tenant) |> Api.create()
  end

  def signup(%{"tenant" => tenant, "user" => user}) do
    case Ash.DataLayer.transact(Eatbeep.Tenant, fn ->
           {:ok, created_tenant} = Ash.Changeset.new(Tenant, tenant) |> Api.create()
           # created_tenant
           {:ok, created_user} = create_user(user, created_tenant)
           {created_tenant, created_user}
         end) do
      {:ok, {tenant, user}} -> {:ok, tenant, user}
      {:error, error} -> {:error, error}
    end
  end

  # end)
  # Multi.new()
  # |> Multi.run(:tenant, fn _repo, _values -> create_tenant(tenant) end)
  # |> Multi.run(:user, fn _repo, %{tenant: tenant} -> create_user(user, tenant) end)
  # |> Eatbeep.Repo.transaction()
end

# the returned error is quite ugly though - I won't be able to match it to the field?

# Eatbeep.Api.get!(Eatbeep.Tenant, "exeecrqy") |> Ash.Changeset.new() |> Ash.Changeset.replace_relationship(:users, [{"yzdgv8h3", %{role: "owner"}}]) |> Eatbeep.Api.update!()

# Ash.DataLayer.transact(Eatbeep.Tenant, fn ->
#   t = Eatbeep.Api.get!(Eatbeep.Tenant, "exeecrqy")
#   Eatbeep.Api.get!(Eatbeep.Tenant, "exeecrqy")
#   true
# end)"
