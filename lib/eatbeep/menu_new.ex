defmodule Eatbeep.NewMenu do

  def save(tenant_id, blocks) do
    # save and then broadcast
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
