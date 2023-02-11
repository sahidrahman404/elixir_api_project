defmodule Readme.Accounts.Registry do
  use Ash.Registry, extensions: [Ash.Registry.ResourceValidations]

  entries do
    entry(Readme.Accounts.Account)
    entry(Readme.Accounts.User)
    entry(Readme.Accounts.Token)
  end
end
