defmodule EatbeepWeb.MenuLive do
  use Surface.LiveView
  alias Surface.Constructs.For

  # alias Eatbeep.NewMenu

  data blocks, :list


  def mount(_params, %{"tenant_id" => tenant_id}, socket) do

    # if connected?(socket), do: Menu.subscribe()
    # only subscribe if you're actually using it, surely?
    {:ok, socket |> assign_new(:blocks, fn -> Eatbeep.Menu.get(tenant_id) |> IO.inspect(label: "fetched") end) |> assign(:tenant_id, tenant_id)}
  end

  def handle_event("save", _params,  %{assigns: assigns} = socket) do
    %{tenant_id: tenant_id, blocks: blocks} = assigns
    Eatbeep.Menu.save(tenant_id, blocks)
    {:noreply, socket}
    # use the task.async thing to persist and rebroadcast, in async way
    # use both presence channel and database? database is only if saved?
  end



  def handle_event("move_block", params, %{assigns: assigns} = socket) do

    %{"old_index" => old_index, "new_index" => new_index} = params

    {popped, remaining} = List.pop_at(assigns.blocks, old_index)

   blocks = if new_index > old_index do
      IO.puts("moving down list")
      List.insert_at(remaining, new_index, popped)
    else
      IO.puts("moving up list")
      IO.inspect(remaining, label: "remaining")
      List.insert_at(remaining, new_index, popped)
    end



    IO.inspect(blocks, label: "end result")


    {:noreply, socket |> assign(:blocks, blocks)}
  end

  # need to add, edit, delete and move blocks...easy

  def render(assigns) do

    ~H"""
    <div>Menu, ready to edit</div>
    <div phx-hook="sortable" id="menu">
      <For each={{ block <- @blocks }}>
        <div class="border p-6">{{ block["__type"] }} - {{ block["contents"] }}<button class="border ml-3 move-button">move</button></div>
      </For>
      <button :on-click="save">Save changes</button>
    </div>
    """
  end
end
