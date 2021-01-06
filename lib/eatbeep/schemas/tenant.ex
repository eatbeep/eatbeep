defmodule Eatbeep.Tenant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tenants" do
    field :name, :string
    field :subdomain, :string
    field :custom_domain, :string
    field :email, :string
    field :hashed_password, :string
    field :menu, {:array, :map}
    field :password, :string, virtual: true
    field :accept_terms, :boolean, virtual: true

    # meta - browser details

    timestamps()

    # status - demo etc.
    # user status - email validated
  end

  def signup_changeset(tenant, attrs \\ %{}) do
    tenant
    |> cast(attrs, ~w(name email password accept_terms)a)
    |> validate_required([:name, :email, :password, :accept_terms])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> validate_acceptance(:accept_terms, message: "please accept rules")

    # generate the subdomain
    # hash the password
    # set
  end
end
