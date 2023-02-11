defmodule Readme.ArticlesComments do
  use Ash.Api,
    extensions: [
      AshGraphql.Api
    ]

  graphql do
    authorize? false
  end

  resources do
    registry Readme.ArticlesComments.Registry
  end
end
