defmodule EatbeepWeb.Menu.HeadingForm do
  use Surface.LiveComponent
  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, Label, TextInput, Submit, ErrorTag, HiddenInput}
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
        <Field name="heading" class="space-y-1">
          <Label>Heading</Label>
          <TextInput class="input" opts={{ placeholder: "eg. Acme Pizza"}} />
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
     cset = Blocks.heading_changeset(params) |> Map.put(:action, :update)
     if cset.valid? do
      send(self(), {:update_block, cset.changes})
      {:noreply, socket}
     else
      {:noreply, socket |> assign(:changeset, cset)}
     end
   end
end
