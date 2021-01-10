defmodule EatbeepWeb.Menu.Hero do
  use Surface.Component
  alias EatbeepWeb.Menu.Dialog
  alias EatbeepWeb.Menu.HeroForm

  prop block, :any

  def render(assigns) do
    unsplash = Map.get(assigns.block, :background, "h0Vxgz5tyXA")
    background_url = "url(https://source.unsplash.com/#{unsplash}/1400x400)"

    ~H"""
    <section class="px-4 py-32 mx-auto bg-center bg-no-repeat" style={{ background: background_url }}>
      <div class="w-full mx-auto md:w-11/12 xl:w-8/12 text-center">
        <h1 class="mb-3 text-3xl font-bold text-white md:text-6xl md:leading-tight md:font-extrabold">{{ @block.name }}</h1>
      </div>
    </section>
    <Dialog title="Edit hero" id={{ @block.bid }}>
      <HeroForm
        id={{ @block.bid }}
        block={{ @block }}
      />
    </Dialog>
    """
  end

end
