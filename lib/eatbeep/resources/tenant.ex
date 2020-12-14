defmodule Eatbeep.Tenant do
  use Ash.Resource, data_layer: AshPostgres.DataLayer
  alias Eatbeep.{User, Role, Menu}

  def random_id, do: Nanoid.generate(8, "0123456789abcdefghijklmnopqrstuvwxyz")

  postgres do
    table "tenants"
    repo Eatbeep.Repo
  end

  resource do
    identities do
      identity :unique_subdomain, [:subdomain]
    end
  end

  attributes do
    attribute :id, :string do
      primary_key? true
      default &__MODULE__.random_id/0
    end

    attribute :name, :string do
      allow_nil? false
      constraints max_length: 255
    end

    attribute :subdomain, :string do
      constraints max_length: 50
      # add slug constraint
    end

    # some sort of status? and so maybe not signed up at all?

    create_timestamp :created_at

    update_timestamp :updated_at
  end

  relationships do
    many_to_many :users, User,
            through: Role,
            source_field_on_join_table: :tenant_id,
            destination_field_on_join_table: :user_id,
            join_attributes: [:role]

    has_many :menus, Menu, destination_field: :tenant_id

  end

  actions do
    create :default do
      primary? true
    end

    read :default

    update :default
    destroy :default
  end
end
