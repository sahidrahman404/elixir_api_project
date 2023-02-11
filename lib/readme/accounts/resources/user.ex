defmodule Readme.Accounts.User do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  attributes do
    uuid_primary_key(:id)
    create_timestamp(:created_at)
    update_timestamp(:updated_at)

    attribute(:bio, :string)
    attribute(:first_name, :string)
    attribute(:last_name, :string)
    attribute(:display_picture, :string)
  end

  postgres do
    table "user"
    repo Readme.Repo
  end

  relationships do
    belongs_to :account, Readme.Accounts.Account do
      allow_nil? false
    end
  end
end
