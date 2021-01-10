defmodule EatbeepWeb.Menu.Product do
  use Surface.Component
  alias EatbeepWeb.Menu.Dialog
  alias EatbeepWeb.Menu.ProductForm

  prop block, :any

  def render(assigns) do

    ~H"""
    <section class="container px-4 py-4 mx-auto space-y-4">
      <div class="w-full mx-auto md:w-11/12 xl:w-8/12 text-center">
        <h3 class="text-base font-bold text-gray-900 md:text-lg md:leading-tight md:font-extrabold">{{ @block.name }}</h3>

      </div>
      <div>
      <p class="text-gray-600 max-w-lg text-sm md:text-base mx-auto text-center">{{ @block.description }}
      </p>
    </div>

    </section>
    <Dialog title="Edit heading" id={{ @block.bid }}>
      <ProductForm
        id={{ @block.bid }}
        block={{ @block }}
      />
    </Dialog>
    """
  end

end
