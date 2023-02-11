defmodule Readme.ArticlesComments.CommentLike do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  attributes do
    integer_primary_key(:id)
    create_timestamp(:created_at)
    update_timestamp(:updated_at)
  end

  postgres do
    table "articles_comments_likes"
    repo Readme.Repo
  end

  relationships do
    belongs_to :articles_comments, Readme.ArticlesComments.Comment do
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
