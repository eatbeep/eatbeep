defmodule EatbeepWeb.Menu.HeroForm do
  use Surface.LiveComponent
  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, Label, TextInput, Submit, ErrorTag, HiddenInput, RadioButton}
  alias Eatbeep.Blocks

  data changeset, :any
  prop block, :any

  @pictures ~w(h0Vxgz5tyXA wKTF65TcReY pJadQetzTkI)a

  def update(assigns, socket) do
    cset = Blocks.hero_changeset(assigns.block)
    {:ok, socket |> assign(changeset: cset)}
  end

  def render(assigns) do
    pictures = @pictures
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
        <Field name="background">
        <div class="grid grid-cols-3 gap-x-4">
          <label :for={{ picture <- pictures }} class="border p-2 rounded block">
            <div class="h-32 bg-center bg-no-repeat" style={{ background: "url(#{"https://source.unsplash.com/#{picture}/200x130"}"}} />
            <div class="flex justify-center p-3">
            <RadioButton value={{ picture }} />
            </div>
          </label>

        </div>
      </Field>
        <Submit class="btn btn-primary">Update</Submit>
      </div>
      </Form>
    """
  end

   def handle_event("submit", %{"block" => params}, socket) do
     cset = Blocks.hero_changeset(params) |> Map.put(:action, :update) |> IO.inspect(label: "changeset")
     if cset.valid? do
      send(self(), {:update_block, cset.changes})
      {:noreply, socket}
     else
      {:noreply, socket |> assign(:changeset, cset)}
     end
   end
end

# <RadioButton class="h-32 bg-center bg-no-repeat" style={{ background: "url(#{"https://source.unsplash.com/wKTF65TcReY/200x130"}"}} />
# <RadioButton class="h-32 bg-center bg-no-repeat" style={{ background: "url(#{"https://source.unsplash.com/pJadQetzTkI/200x130"}"}} />
