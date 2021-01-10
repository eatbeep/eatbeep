defmodule Eatbeep.Signup do
  alias Ecto.Multi
  alias Eatbeep.Repo
  alias Eatbeep.Login
  alias Ecto.Changeset

  def signup(changeset) do

    with_blocks = changeset |> Changeset.put_change(:blocks, Eatbeep.Blocks.generate_starting_data())

    Multi.new()
    |> Multi.insert(:tenant, with_blocks)
    |> Multi.run(:token, fn _repo, %{tenant: tenant} ->
      Login.generate_login_token(tenant)
    end)
    |> Repo.transaction()
  end
end
