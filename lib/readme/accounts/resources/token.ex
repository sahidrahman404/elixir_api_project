defmodule Readme.Accounts.Token do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication.TokenResource]

  token do
    api Readme.Accounts
  end

  postgres do
    table "tokens"
    repo Readme.Repo
  end
end
