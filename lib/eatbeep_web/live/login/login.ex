defmodule EatbeepWeb.LoginLive do
  use Surface.LiveView
  alias Surface.Components.Form
  alias Eatbeep.Tenant
  alias Eatbeep.Login
  alias Eatbeep.Repo

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

  def mount(_params, %{ "tenant_id" => tenant_id }, socket) do
    cset = Tenant.login_changeset(%Tenant{})
    tenant = Repo.get!(Tenant, tenant_id)
    {:ok, socket |> assign(:tenant_name, tenant.name) |> assign(:tenant_id, tenant_id) |> assign(:changeset, cset)}
  end

  def handle_event("login", %{"tenant" => params}, socket) do
    cset = Tenant.login_changeset(%Tenant{}, params) |> Map.put(:action, :insert)
    %{assigns: %{tenant_id: tenant_id}} = socket

    if cset.valid? do
      case Login.login(tenant_id, cset) do
        {:ok, token} ->
          # redirect with token
          {:noreply, socket}

        {:error, error} ->
          cset = Ecto.Changeset.add_error(cset, :general, error)

          {:noreply,socket |> assign(:changeset, cset)}
      end
    else
      {:noreply, socket |> assign(:changeset, cset)}
    end
  end
end
