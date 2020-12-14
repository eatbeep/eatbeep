defmodule Eatbeep.Menu do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    authorizers: [
      AshPolicyAuthorizer.Authorizer
    ]

  # import Eatbeep.Check.ActorAttributeMatchsRecord

  # multitenancy do
  #   strategy :attribute
  #   attribute :tenant_id
  #   global? true
  # end

  def random_id, do: Nanoid.generate(8, "0123456789abcdefghijklmnopqrstuvwxyz")

  postgres do
    table "menus"
    repo Eatbeep.Repo
  end

  relationships do
    belongs_to :tenant, Eatbeep.Tenant, field_type: :string, required?: true
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

    create_timestamp :created_at

    update_timestamp :updated_at
  end

  actions do
    create :default
    read :default
    update :default
    destroy :default

    # read :minte do
    #   filter tenant_id: actor(:id)
    # end
  end

  # policies do
  #   bypass always() do
  #     authorize_if actor_attribute_equals(:role, "super_admin")
  #   end

  #   policy action_type(:read) do
  #     authorize_if actor_attribute_matches_record(:tenant_id, :tenant_id)
  #   end
  # end
end
