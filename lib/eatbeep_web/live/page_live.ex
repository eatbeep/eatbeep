defmodule EatbeepWeb.PageLive do
  use Surface.LiveView
  alias Surface.Components.LiveRedirect

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end
