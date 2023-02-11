defmodule Readme.Accounts.Account do
  use Ash.Resource, 
    data_layer: AshPostgres.DataLayer, 
    extensions: [AshAuthentication]

  attributes do
    uuid_primary_key :id
    attribute :email, :ci_string, allow_nil?: false
    attribute :hashed_password, :string, allow_nil?: false, sensitive?: true
  end

  authentication do
    api Readme.Accounts

    strategies do
      password :password do
        identity_field :email
      end
    end

    tokens do
      enabled? true
      token_resource Readme.Accounts.Token
      signing_secret fn _, _ ->
        Application.fetch_env(:my_app, :token_signing_secret)
      end
    end
  end

  postgres do
    table "accounts"
    repo Readme.Repo
  end

  identities do
    identity :unique_email, [:email]
  end

  relationships do
    has_one :user, Readme.Accounts.User
    has_many :article, Readme.Articles.Article do
      api Readme.Articles
    end
    has_many :article_like, Readme.Articles.ArticleLike do
      api Readme.Articles
    end
    has_many :article_comment, Readme.ArticlesComments.Comment do
      api Readme.ArticlesComments
    end
    has_many :article_comment_like, Readme.ArticlesComments.CommentLike do
      api Readme.ArticlesComments
    end
  end
end
