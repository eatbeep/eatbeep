defmodule EatbeepWeb.MenuLive do
  use Surface.LiveView
  alias Surface.Constructs.For

  alias Eatbeep.NewMenu

  data blocks, :list

  @fixture [%{__type: "hero", contents: "111"}, %{__type: "text", contents: "222"}, %{__type: "text", contents: "333"}, %{__type: "text", contents: "444"}, %{__type: "text", contents: "555"}]

  def mount(_session, _params, socket) do
    # if connected?(socket), do: Menu.subscribe()
    # only subscribe if you're actually using it, surely?
    {:ok, socket |> load_blocks}
  end

  defp load_blocks(socket) do
    socket |> assign_new(:blocks, fn -> @fixture end)
  end

  defp persist_blocks(data) do
    # use the task.async thing to persist and rebroadcast, in async way
    # use both presence channel and database? database is only if saved?
  end

  def handle_event("move_block", params, %{assigns: assigns} = socket) do
    IO.inspect(params, label: " ===== moving ======")
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

    # Now save this, async

    IO.inspect(blocks, label: "end result")


    {:noreply, socket |> assign(:blocks, blocks)}
  end

  # need to add, edit, delete and move blocks...easy

  def render(assigns) do

    ~H"""
    <div>Menu, ready to edit</div>
    <div phx-hook="sortable" id="menu">
      <For each={{ block <- @blocks }}>
        <div class="border p-6">{{ block.__type }} - {{ block.contents }}<button class="border ml-3 move-button">move</button></div>
      </For>
    </div>
    """
  end
end
