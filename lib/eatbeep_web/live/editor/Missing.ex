defmodule EatbeepWeb.Menu.Missing do
  use Surface.Component

  def render(assigns) do
    ~H"""
    <div class="text-red-500">Missing block</div>
    """
  end
end
