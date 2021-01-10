defmodule EatbeepWeb.Menu.Dynamic do

  use Surface.Component
  alias EatbeepWeb.Menu.{Hero, Heading, Missing}

  prop block, :map, default: %{}

  @components %{
    hero: Hero,
    text: Heading,
    heading: Heading
  }

  def render(assigns) do
    type = Map.get(assigns.block, :__type) |> String.to_atom()
    c = Map.get(@components, type, Missing)

    props =
      %{} |> Map.put(:block, assigns.block)
        # from https://github.com/msaraiva/surface/issues/24
      |> Map.merge(%{__surface__: %{groups: %{__default__: %{binding: false, size: 0}}}})

    ~H"""
    <div class="group focus-within:border-blue-500 border-transparent hover:border-blue-500 border-2 relative">
      {{ live_component(@socket, c, props) }}
      <div class="hidden group-hover:flex space-x-2 top-4 right-4 absolute">
        <button type="button" class="btn btn-small btn-light move-button">move</button>
        <button type="button" :on-click="edit_block" phx-value-id={{ props.block.bid }} class="btn btn-sm btn-light">Edit</button>
      </div>
      </div>
    """
  end

end
