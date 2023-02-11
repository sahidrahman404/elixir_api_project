defmodule Readme.ArticlesComments do
  use Ash.Api

  resources do
    registry Readme.ArticlesComments.Registry
  end
end
