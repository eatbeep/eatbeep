defmodule EatbeepWeb.Menu.HeroForm do
  use Surface.LiveComponent
  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, Label, TextInput, Submit, ErrorTag, HiddenInput}
  alias Eatbeep.Blocks

  data changeset, :any
  prop block, :any

  def update(assigns, socket) do
    cset = Blocks.hero_changeset(assigns.block)
    {:ok, socket |> assign(changeset: cset)}
  end

  def render(assigns) do
    ~H"""
    <Form submit="submit" for={{ @changeset }} as="block">
      <HiddenInput field="__type" />
      <HiddenInput field="bid" />
      <div class="space-y-4">
        <Field name="name" class="space-y-1">
          <Label>Business Name</Label>
          <TextInput class="input" opts={{ placeholder: "eg. Acme Pizza"}} />
          <ErrorTag class="field-error" />
        </Field>
        <Submit class="btn btn-primary">Update</Submit>
      </div>
      </Form>
    """
  end

   def handle_event("submit", %{"block" => params}, socket) do
     cset = Blocks.hero_changeset(params) |> Map.put(:action, :update)
     if cset.valid? do
      send(self(), {:update_block, cset.changes})
      {:noreply, socket}
     else
      {:noreply, socket |> assign(:changeset, cset)}
     end
   end
end
