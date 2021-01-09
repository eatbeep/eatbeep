defmodule Eatbeep.Signup do
  alias Ecto.Multi
  alias Eatbeep.Repo

  def signup(changeset) do
    Multi.new()
    |> Multi.insert(:tenant, changeset)
    |> Repo.transaction()
  end
end
