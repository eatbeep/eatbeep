defmodule EatbeepWeb.SignupLive do
  use Surface.LiveView
  alias Surface.Components.Form
  alias Eatbeep.Signup

  alias Surface.Components.Form.{
    Field,
    Label,
    TextInput,
    EmailInput,
    Submit,
    PasswordInput,
    Checkbox,
    ErrorTag
  }

  alias Eatbeep.Tenant

  def mount(_session, _params, socket) do
    cset = Tenant.signup_changeset(%Tenant{})

    {:ok, socket |> assign(:changeset, cset)}
  end

  def handle_event("signup", %{"tenant" => params}, socket) do
    cset = Tenant.signup_changeset(%Tenant{}, params) |> Map.put(:action, :insert)

    if cset.valid? do
      case Signup.signup(cset) do
        {:ok, %{tenant: tenant, token: token}} ->
          url = "https://#{tenant.subdomain}.eatbeep.com/menu?ott=#{token}"
          {:noreply, socket |> redirect(external: url)}

        {:error, _, failed_change, _} ->
         {:noreply, socket |> assign(:changeset, failed_change)}
      end
    else
      {:noreply, socket |> assign(:changeset, cset)}
    end
  end
end
