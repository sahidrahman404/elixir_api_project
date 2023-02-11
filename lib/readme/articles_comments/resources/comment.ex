defmodule Readme.ArticlesComments.Comment do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    uuid_primary_key(:id)
    create_timestamp(:created_at)
    update_timestamp(:updated_at)

    attribute :content, :string do
      allow_nil?(false)
    end

    attribute :path, :string do
      allow_nil?(false)
      generated?(true)
    end

    attribute :parent_path, :string 
  end

  postgres do
    table "articles_comments"
    repo Readme.Repo
  end

  relationships do
    belongs_to :account, Readme.Accounts.Account do
      api Readme.Accounts
      allow_nil?(false)
    end
  end
end
