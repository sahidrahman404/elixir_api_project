defmodule Readme.ArticlesComments.CommentLike do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  graphql do
    type(:article_comment_like)

    queries do
      get(:get_comment_like, :read)
      list(:list_comment_like, :read)
    end

    mutations do
      create :create_comment_like, :create_comment_like
    end
  end

  actions do
    defaults([:create, :read, :update, :destroy])

    create :create_comment_like do
      argument(:articles_comments_id, :integer)
      argument(:accounts_id, :integer)

      change(
        manage_relationship(:articles_comments_id, :articles_comments,
          type: :append_and_remove
        )
      )

      change(
        manage_relationship(:accounts_id, :accounts,
          type: :append_and_remove
        )
      )
    end
  end

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
      attribute_type(:integer)
    end

    belongs_to :accounts, Readme.Accounts.Account do
      api Readme.Accounts
      allow_nil?(false)
      attribute_type(:integer)
    end
  end
end
