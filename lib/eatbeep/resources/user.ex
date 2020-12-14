defmodule Eatbeep.User do
  use Ash.Resource, data_layer: AshPostgres.DataLayer
  import Eatbeep.HashPassword, only: [hash_password: 0]

  def random_id, do: Nanoid.generate(8, "0123456789abcdefghijklmnopqrstuvwxyz")

  postgres do
    table "users"
    repo Eatbeep.Repo
  end

  resource do
    identities do
      identity :unique_email, [:email]
    end
  end

  relationships do
    #  has_many :roles, Eatbeep.Role, destination_field: :user_id
    many_to_many :tenants, Eatbeep.Tenant,
    through: Eatbeep.Role,
    source_field_on_join_table: :user_id,
    destination_field_on_join_table: :tenant_id,
    join_attributes: [:role]
  end

  attributes do
    attribute :id, :string do
      primary_key? true
      default &__MODULE__.random_id/0
    end

    attribute :name, :string do
      allow_nil? false
      constraints max_length: 50
    end

    attribute :email, :string do
      constraints max_length: 50
    end

    attribute :hashed_password, :string do
      allow_nil? true
    end

    create_timestamp :created_at

    update_timestamp :updated_at
  end

  actions do
    create :default do
      primary? true
    end

    create :signup do
      argument :password, :string do
        allow_nil? false
      end
    end

    create :set_password do
      argument :password, :string
      change hash_password()
    end

    read :default
  end
end
