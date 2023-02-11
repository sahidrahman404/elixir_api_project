defmodule Readme.Articles.ArticleLike do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  actions do
    defaults([:read, :create, :update, :destroy])
  end

  attributes do
    uuid_primary_key(:id)
    create_timestamp(:created_at)
    update_timestamp(:updated_at)
  end

  postgres do
    table "articles_likes"
    repo Readme.Repo
  end

  relationships do
    belongs_to :article, Readme.Articles.Article do
      allow_nil?(false)
    end

    belongs_to :account, Readme.Accounts.Account do
      api Readme.Accounts
      allow_nil? false
    end
  end
end
