defmodule Readme.Articles do
  use Ash.Api

  resources do
    registry(Readme.Articles.Registry)
  end
end
