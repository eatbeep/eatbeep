defmodule EatbeepWeb.SignupLive do
  use Surface.LiveView
  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, Label, TextInput, EmailInput, Submit, PasswordInput, Checkbox, ErrorTag}
  alias Eatbeep.Tenant

  def mount(session, _params, socket) do
    cset = Tenant.signup_changeset(%Tenant{})

    {:ok, socket |> assign(:changeset, cset)}
  end

  def handle_event("signup", %{"tenant" => params}, socket) do
    cset = Tenant.signup_changeset(%Tenant{}, params) |> Map.put(:action, :insert)
    IO.inspect(cset, label: "cset")
    {:noreply, socket |> assign(:changeset, cset)}
  end


end
