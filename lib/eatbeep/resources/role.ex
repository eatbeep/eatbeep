defmodule Eatbeep.Role do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  def random_id, do: Nanoid.generate(8, "0123456789abcdefghijklmnopqrstuvwxyz")

  postgres do
    table "roles"
    repo Eatbeep.Repo
  end

  attributes do
    attribute :role, :string do
      allow_nil? false
      constraints max_length: 50
    end

    create_timestamp :created_at

    update_timestamp :updated_at
  end

  relationships do
    belongs_to :tenant, Eatbeep.Tenant, primary_key?: true, field_type: :string
    belongs_to :user, Eatbeep.User, primary_key?: true, field_type: :string
  end

  actions do
    create :default
    read :default
    update :default
    destroy :default
  end


end
