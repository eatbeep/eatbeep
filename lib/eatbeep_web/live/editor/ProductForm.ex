defmodule EatbeepWeb.Menu.ProductForm do
  use Surface.LiveComponent
  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, Label, TextInput, Submit, ErrorTag, HiddenInput, TextArea}
  alias Eatbeep.Blocks

  data changeset, :any
  data bid, :string
  prop block, :any

  def update(assigns, socket) do
    cset = Blocks.heading_changeset(assigns.block)
    {:ok, socket |> assign(:changeset, cset) |> assign(:bid, assigns.block.bid)}
  end

  def render(assigns) do
    ~H"""
    <Form submit="submit" for={{ @changeset }} as="block">
      <HiddenInput field="__type" />
      <HiddenInput field="bid" />
      <div class="space-y-4">
        <Field name="name" class="space-y-1">
          <Label>Name</Label>
          <TextInput class="input" opts={{ placeholder: "eg. Pepperoni Pizza"}} />
          <ErrorTag class="field-error" />
        </Field>

        <Field name="description" class="space-y-1">
          <Label>Description</Label>
          <TextArea class="input" opts={{ placeholder: ""}} rows="4" />
          <ErrorTag class="field-error" />
        </Field>

        <div class="flex justify-between">
          <button type="button" data-confirm="Are you sure?" phx-click="delete_block" phx-value-id={{ @bid }} class="btn btn-light-danger">Delete</button>
          <Submit class="btn btn-primary">Update</Submit>
        </div>
      </div>
      </Form>
    """
  end

   def handle_event("submit", %{"block" => params}, socket) do
     cset = Blocks.product_changeset(params) |> Map.put(:action, :update)
     if cset.valid? do
      send(self(), {:update_block, cset.changes})
      {:noreply, socket}
     else
      {:noreply, socket |> assign(:changeset, cset)}
     end
   end
end
