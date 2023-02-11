defmodule Readme.Accounts do
  use Ash.Api

  resources do
    registry(Readme.Accounts.Registry)
  end
end
