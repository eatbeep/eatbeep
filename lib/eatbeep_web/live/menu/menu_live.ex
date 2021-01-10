defmodule EatbeepWeb.MenuLive do
  use Surface.LiveView
  alias Surface.Constructs.{For}
  alias EatbeepWeb.Menu.{DynamicSimple, Dialog}
  alias Eatbeep.Blocks

  data blocks, :list
  data tenant_id, :integer

  @components %{
    hero: Hero,
    text: Heading,
    heading: Heading,
    product: Product
  }

  def mount(_params, %{"tenant_id" => tenant_id}, socket) do
    {:ok,
      socket
      |> assign_new(:blocks, fn -> Eatbeep.Menu.get(tenant_id) end)
      |> assign(:tenant_id, tenant_id)
    }
  end

  def render(assigns) do

    ~H"""
    <div :for={{ block <- @blocks }}>
      <DynamicSimple block={{ block}} />
    </div>
    """
  end
end
