defmodule Readme.Accounts do
  use Ash.Api,
    extensions: [
      AshGraphql.Api
    ]

  graphql do
    authorize? false
  end

  resources do
    registry(Readme.Accounts.Registry)
  end
end
