defmodule Eatbeep.Tenant do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eatbeep.Tenant
  alias Eatbeep.Repo

  schema "tenants" do
    field :name, :string
    field :subdomain, :string
    field :custom_domain, :string
    field :email, :string
    field :hashed_password, :string
    field :menu, {:array, :map}
    field :password, :string, virtual: true
    field :accept_terms, :boolean, virtual: true

    timestamps()
  end

  def login_changeset(tenant, attrs \\ %{}) do
    tenant
    |> cast(attrs, ~w(email password)a)
    |> validate_required([:email, :password])
  end

  def signup_changeset(tenant, attrs \\ %{}) do
    tenant
    |> cast(attrs, ~w(name email password accept_terms)a)
    |> validate_required([:name, :email, :password, :accept_terms])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> validate_acceptance(:accept_terms, message: "Please accept terms and conditions")
    |> ensure_subdomain(1)
    |> maybe_hash_password()
    # set
  end

  def ensure_subdomain(%Ecto.Changeset{changes: %{name: name}} = changeset, attempt) when is_binary(name) do
    subdomain = slugify(name, attempt)

    case Repo.get_by(Tenant, subdomain: subdomain) do
      nil ->
        changeset |> put_change(:subdomain, subdomain)
      _ ->
        ensure_subdomain(changeset, attempt + 1)
    end
  end

  def ensure_subdomain(changeset, _), do: changeset

  def slugify(name, 1) do
    Slug.slugify(name)
  end
  def slugify(name, _) do
    suffix = Enum.random(9999..99999) |> to_string()
    Slug.slugify(name <> "-" <> suffix)
  end

  defp maybe_hash_password(changeset) do
    password = get_change(changeset, :password)

    if password && changeset.valid? do
      changeset
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end

  def get_by_subdomain(subdomain) do
    Repo.get_by(Tenant, subdomain: subdomain)
  end

  def get_url(tenant_id) do
    tenant = Repo.get!(Tenant, tenant_id)
    "https://#{tenant.subdomain}.eatbeep.com"
  end
end
