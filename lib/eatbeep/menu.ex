defmodule Eatbeep.Menu do
  alias Eatbeep.{Repo, Tenant}

  @fixture [
    %{__type: "hero", contents: "111"},
    %{__type: "text", contents: "222"},
    %{__type: "text", contents: "333"},
    %{__type: "text", contents: "444"},
    %{__type: "text", contents: "555"}
  ]

  def get(tenant_id) do
    case Repo.get(Tenant, tenant_id) do
      nil -> @fixture
      %Tenant{menu: nil} -> @fixture
      tenant -> tenant |> Map.get(:menu)
    end
  end

  def save(tenant_id, menu) do
    Repo.get(Tenant, tenant_id)
    |> Ecto.Changeset.change(%{menu: menu})
    |> Repo.update()

  end

  def subscribe(tenant_id) do
    Phoenix.PubSub.subscribe(Eatbeep.PubSub, "tenant:#{tenant_id}")
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, tenant}, event) do
    Phoenix.PubSub.broadcast(Eatbeep.PubSub, "tenant", {event, tenant})
    {:ok, tenant}
  end
end
