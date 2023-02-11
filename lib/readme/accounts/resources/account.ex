defmodule Readme.Accounts.Account do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication]

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
    identity(:unique_email, [:email])
  end

  relationships do
    has_one :users, Readme.Accounts.User
  end
end
