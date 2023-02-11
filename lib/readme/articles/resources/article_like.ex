defmodule Readme.Articles.ArticleLike do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  actions do
    defaults([:read, :create, :update, :destroy])
  end

  attributes do
    integer_primary_key(:id)
    create_timestamp(:created_at)
    update_timestamp(:updated_at)
  end

  postgres do
    table "articles_likes"
    repo Readme.Repo
  end

  relationships do
    belongs_to :articles, Readme.Articles.Article do
      allow_nil?(false)
      attribute_type :integer
    end

    belongs_to :accounts, Readme.Accounts.Account do
      api Readme.Accounts
      allow_nil?(false)
      attribute_type :integer
    end
  end
end
