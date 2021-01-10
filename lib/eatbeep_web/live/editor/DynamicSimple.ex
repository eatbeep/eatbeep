defmodule EatbeepWeb.Menu.DynamicSimple do

  use Surface.Component
  alias EatbeepWeb.Menu.{Hero, Heading, Missing, Product}

  prop block, :map, default: %{}

  @components %{
    hero: Hero,
    text: Heading,
    heading: Heading,
    product: Product
  }

  def render(assigns) do
    type = Map.get(assigns.block, :__type) |> String.to_atom()
    c = Map.get(@components, type, Missing)

    props =
      %{} |> Map.put(:block, assigns.block)
        # from https://github.com/msaraiva/surface/issues/24
      |> Map.merge(%{__surface__: %{groups: %{__default__: %{binding: false, size: 0}}}})

    ~H"""
      {{ live_component(@socket, c, props) }}
    """
  end

end
