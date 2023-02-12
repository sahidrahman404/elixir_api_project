defmodule Readme.Accounts.Account do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication, AshGraphql.Resource]

  graphql do
    type(:account)

    queries do
      get(:account, :read)

      get :sign_in_with_password, :sign_in_with_password do
        # tell it not to use anything for looking up
        type_name(:account_with_token)
        identity(false)
        as_mutation?(true)
      end
    end

    mutations do
      create :register_with_password, :register_with_password
    end
  end

  actions do
    defaults([:read])
  end

  attributes do
    integer_primary_key(:id)
    attribute(:email, :ci_string, allow_nil?: false)
    attribute(:hashed_password, :string, allow_nil?: false, sensitive?: true)
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
      store_all_tokens? true
      require_token_presence_for_authentication? true

      signing_secret fn _, _ ->
        Application.fetch_env(:readme, :token_signing_secret)
      end
    end
  end

  changes do
    change(Readme.Accounts.User.Changes.RemoveAllTokens,
      where: [action_is(:password_reset_with_password)]
    )
  end

  postgres do
    table "accounts"
    repo Readme.Repo
  end

  identities do
    identity(:unique_email, [:email])
  end

  relationships do
    has_one :users, Readme.Accounts.User
  end
end
