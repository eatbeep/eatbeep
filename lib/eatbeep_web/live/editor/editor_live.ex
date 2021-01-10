defmodule EatbeepWeb.EditorLive do
  use Surface.LiveView
  alias Surface.Constructs.{For}
  alias EatbeepWeb.Menu.{Dynamic, Dialog}
  alias Eatbeep.Blocks

  data blocks, :list
  data tenant_id, :integer

  def mount(_params, %{"tenant_id" => tenant_id}, socket) do

    {:ok,
      socket
      |> assign_new(:blocks, fn -> Eatbeep.Menu.get(tenant_id) end)
      |> assign(:tenant_id, tenant_id)
    }
  end

  def handle_event("save", _params, %{assigns: assigns} = socket) do
    %{tenant_id: tenant_id, blocks: blocks} = assigns
    Eatbeep.Menu.save(tenant_id, blocks)
    {:noreply, socket |> put_flash(:info, "Changes saved")}
  end

  def handle_event("move_block", params, %{assigns: assigns} = socket) do
    %{"old_index" => old_index, "new_index" => new_index} = params

    {popped, remaining} = List.pop_at(assigns.blocks, old_index)

    blocks = List.insert_at(remaining, new_index, popped)

    {:noreply, socket |> assign(:blocks, blocks)}
  end

  def handle_event("edit_block", %{"id" => id}, socket) do
    Dialog.show(id)
    {:noreply, socket}
  end

  def handle_event("add_block", %{"type" => type, "after" => aft}, socket) do
    %{assigns: %{blocks: blocks}} = socket
    position = Enum.find_index(blocks, fn b -> b.bid == aft end) + 1

    new_block = Blocks.new_block(type)

    updated_blocks = List.insert_at(blocks, position, new_block)

    {:noreply, socket |> assign(:blocks, updated_blocks)}
  end

  def handle_event("delete_block", %{"id" => id}, socket) do
    %{assigns: %{blocks: blocks}} = socket
    updated_blocks = Enum.reject(blocks, fn b -> b.bid == id end)
    Dialog.hide(id)
    {:noreply, socket |> assign(:blocks, updated_blocks)}
  end

  def handle_info({:update_block, payload}, socket) do
    %{bid: bid} = payload
    %{assigns: %{blocks: blocks}} = socket
    position = Enum.find_index(blocks, fn b -> b.bid == bid end)

    updated_blocks = List.replace_at(blocks, position, payload)

    Dialog.hide(payload.bid)
    {:noreply, socket |> assign(:blocks, updated_blocks)}
  end

end
