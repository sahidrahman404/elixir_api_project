defmodule Readme.ArticlesComments.Registry do
  use Ash.Registry, extensions: [Ash.Registry.ResourceValidations]

  entries do
    entry Readme.ArticlesComments.Comment
    entry Readme.ArticlesComments.CommentLike
  end
end
