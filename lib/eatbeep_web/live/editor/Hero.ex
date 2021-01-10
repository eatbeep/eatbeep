defmodule EatbeepWeb.Menu.Hero do
  use Surface.Component
  alias EatbeepWeb.Menu.Dialog
  alias EatbeepWeb.Menu.HeroForm

  prop block, :any

  def render(assigns) do

    ~H"""
    <section class="container px-4 py-32 mx-auto">
      <div class="w-full mx-auto md:w-11/12 xl:w-8/12 text-center">
        <h1 class="mb-3 text-4xl font-bold text-gray-900 md:text-5xl md:leading-tight md:font-extrabold">{{ @block.name }}</h1>
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
