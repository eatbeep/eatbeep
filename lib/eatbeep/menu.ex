defmodule Eatbeep.Menu do
  alias Eatbeep.{Repo, Tenant}

  @fixture [
    %{__type: "hero", name: "111"},
    %{__type: "text", contents: "222"},
    %{__type: "text", contents: "333"},
    %{__type: "text", contents: "444"},
    %{__type: "text", contents: "555"}
  ]

  def key_to_atom(map) do
    Enum.reduce(map, %{}, fn
      {key, value}, acc when is_atom(key) -> Map.put(acc, key, value)
      {key, value}, acc when is_binary(key) -> Map.put(acc, String.to_existing_atom(key), value)
    end)
  end

  def get(tenant_id) do
    res = case Repo.get(Tenant, tenant_id) do
      nil -> @fixture
      %Tenant{menu: nil} -> @fixture
      tenant -> tenant |> Map.get(:menu)
    end

    res |> Enum.map(&key_to_atom/1)
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
