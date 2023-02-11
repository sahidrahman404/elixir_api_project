defmodule Readme.ArticlesComments.CommentLike do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  attributes do
    uuid_primary_key(:id)
    create_timestamp(:created_at)
    update_timestamp(:updated_at)
  end

  postgres do
    table "articles_comments_likes"
    repo Readme.Repo
  end

  relationships do
    belongs_to :article_comment, Readme.ArticlesComments.Comment do
      allow_nil?(false)
    end

    belongs_to :account, Readme.Accounts.Account do
      api Readme.Accounts
      allow_nil? false
    end
  end
end
