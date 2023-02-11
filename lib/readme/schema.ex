defmodule Readme.Schema do
  use Absinthe.Schema

  @apis [Readme.Accounts, Readme.Articles, Readme.ArticlesComments]

  use AshGraphql, apis: @apis

  # The query and mutation blocks is where you can add custom absinthe code
  query do
  end

  mutation do
  end

  def context(ctx) do
    AshGraphql.add_context(ctx, @apis)
  end

  def plugins() do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end
end
