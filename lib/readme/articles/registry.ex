defmodule Readme.Articles.Registry do
  use Ash.Registry,
    extensions: [Ash.Registry.ResourceValidations]

  entries do
    entry(Readme.Articles.Article)
    entry(Readme.Articles.ArticleLike)
  end
end
