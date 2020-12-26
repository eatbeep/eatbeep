defmodule Eatbeep.Signup do
  # alias Eatbeep.Api
  # alias Eatbeep.{Tenant, User, Role}
  # alias Ecto.Multi

  # defp create_user(user, tenant) do
  #   Ash.Changeset.new(User, user)
  #   |> Ash.Changeset.replace_relationship(:tenants, [{tenant.id, %{role: "owner"}}])
  #   |> Api.create(action: :signup)
  # end

  # defp create_tenant(tenant) do
  #   Ash.Changeset.new(Tenant, tenant) |> Api.create()
  # end

  # def signup(%{"tenant" => tenant, "user" => user}) do
  #   case Ash.DataLayer.transact(Eatbeep.Tenant, fn ->
  #          {:ok, created_tenant} = Ash.Changeset.new(Tenant, tenant) |> Api.create()
  #          # created_tenant
  #          {:ok, created_user} = create_user(user, created_tenant)
  #          {created_tenant, created_user}
  #        end) do
  #     {:ok, {tenant, user}} -> {:ok, tenant, user}
  #     {:error, error} -> {:error, error}
  #   end
  # end

  # end)
  # Multi.new()
  # |> Multi.run(:tenant, fn _repo, _values -> create_tenant(tenant) end)
  # |> Multi.run(:user, fn _repo, %{tenant: tenant} -> create_user(user, tenant) end)
  # |> Eatbeep.Repo.transaction()
end
