defmodule Eatbeep.Repo.Migrations.CreateTenant do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:tenants) do
      add :name, :text, null: false
      add :subdomain, :citext, null: false
      add :custom_domain, :citext
      add :hashed_password, :text, null: false
      add :email, :citext, null: false
      add :menu, :jsonb


      timestamps()
    end

    create unique_index(:tenants, [:email])
    create unique_index(:tenants, [:subdomain])
    create unique_index(:tenants, [:custom_domain])

    # tokens

  end


end
