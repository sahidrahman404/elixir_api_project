defmodule Readme.Articles.Article do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    integer_primary_key(:id)
    create_timestamp(:created_at)
    update_timestamp(:updated_at)

    attribute :title, :string do
      allow_nil?(false)
    end

    attribute :sub_title, :string do
      allow_nil?(false)
    end

    attribute :story, :string do
      allow_nil?(false)
    end
  end

  postgres do
    table "articles"
    repo Readme.Repo
  end

  relationships do
    belongs_to :accounts, Readme.Accounts.Account do
      api Readme.Accounts
      allow_nil?(false)
      attribute_type :integer
    end
  end
end
