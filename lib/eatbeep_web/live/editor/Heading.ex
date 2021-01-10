defmodule EatbeepWeb.Menu.Heading do
  use Surface.Component
  alias EatbeepWeb.Menu.Dialog
  alias EatbeepWeb.Menu.HeadingForm

  prop block, :any

  def render(assigns) do

    ~H"""
    <section class="container px-4 py-4 mx-auto">
      <div class="w-full mx-auto text-left md:w-11/12 xl:w-8/12 md:text-center">
        <h2 class="text-xl font-bold text-gray-900 md:text-2xl md:leading-tight md:font-extrabold">{{ @block.heading }}</h2>
      </div>
    </section>
    <Dialog title="Edit heading" id={{ @block.bid }}>
      <HeadingForm
        id={{ @block.bid }}
        block={{ @block }}
      />
    </Dialog>
    """
  end

end
