defmodule EatbeepWeb.PageLive do
  use EatbeepWeb, :live_view

  @default_menu "p5ydv7qn"

  defp get_menu_from_session(session) do
    IO.inspect(session, label: "session")
   if (session["logged_in?"]) do
    Eatbeep.Menu |> Ash.Query.set_tenant(session["tenant_id"]) |> Eatbeep.Api.read_one()
   else
    # how to copy the default one?
    default = Eatbeep.Menu |> Eatbeep.Api.get!(@default_menu)

    IO.inspect(default)

    # Eatbeep.Menu |>
   end
  end

  @impl true
  def mount(_params, session, socket) do
    {:ok, assign(socket, logged_in?: session["logged_in?"], menu: get_menu_from_session(session))}
  end

  def handle_event("update", params, socket) do
    # update the menu, based on the menu?

    {:noreply, socket}
  end

end
