defmodule Readme.Articles do
  use Ash.Api,
    extensions: [
      AshGraphql.Api
    ]

  graphql do
    authorize? false
  end

  resources do
    registry(Readme.Articles.Registry)
  end
end
