defmodule Readme.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  graphql do
    type(:user)

    queries do
      list :list_users, :read
      get :get_user, :read
    end
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    integer_primary_key(:id)
    create_timestamp(:created_at)
    update_timestamp(:updated_at)

    attribute(:bio, :string)
    attribute(:first_name, :string)
    attribute(:last_name, :string)
    attribute(:display_picture, :string)
  end

  postgres do
    table "users"
    repo Readme.Repo
  end

  relationships do
    belongs_to :account, Readme.Accounts.Account do
      allow_nil?(false)
      attribute_type(:integer)
    end
  end
end
