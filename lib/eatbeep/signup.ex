defmodule Eatbeep.Signup do
  alias Ecto.Multi
  alias Eatbeep.Repo
  alias Eatbeep.Login

  def signup(changeset) do
    Multi.new()
    |> Multi.insert(:tenant, changeset)
    |> Multi.run(:token, fn _repo, %{tenant: tenant} ->
      Login.generate_login_token(tenant)
    end)
    |> Repo.transaction()
  end
end
