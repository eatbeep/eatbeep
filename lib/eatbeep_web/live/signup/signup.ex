defmodule EatbeepWeb.SignupLive do
  use Surface.LiveView
  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, Label, TextInput, EmailInput, Submit, Inputs}
  def mount(_session, _params, socket) do
    IO.inspect(_session, label: "mounted")
    {:ok, socket}
  end

  def handle_event("signup", params, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gray-50 flex items-center">
    <div class="max-w-md w-full bg-white mx-auto p-8 border">
    <Form for={{ :foo }} submit="signup">
    <div class="space-y-8">
      <Inputs for={{ :tenant }}>
        <Field name="name">
        <Label>Business Name</Label>
          <div class="control">
            <TextInput  />
          </div>
        </Field>
      </Inputs>
      <Field name="email">
        <Label/>
          <div class="control">
            <EmailInput opts={{ placeholder: "eg. ben@example.com"}} />
          </div>
      </Field>
      <Field name="password">
      <Label/>
        <div class="control">
          <TextInput  />
        </div>
      </Field>
      <Submit class="px-3 py-2 bg-blue-900 text-white">Signup</Submit>
      </div>
    </Form>
    </div>
    </div>
    """
  end
end
