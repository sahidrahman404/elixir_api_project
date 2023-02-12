defmodule Readme.Accounts.Account.Changes.RemoveAllTokens do
  @moduledoc """
  Removes all tokens for a given user.

  Since Ash does not yet support bulk actions, this goes straight to the data layer.
  """
  use Ash.Resource.Change
  require Ash.Query

  def change(changeset, _opts, _context) do
    Ash.Changeset.after_action(
      changeset,
      fn _changeset, account ->
        # Ash doesn't support bulk updates yet, so
        # we use this escape hatch to run an ecto query.
        # if you're not using AshPostgres, you'll need to figure
        # this part out on your own.
        {:ok, query} =
          Readme.Accounts.Token
          |> Ash.Query.filter(account_id == ^account.id)
          |> Ash.Query.data_layer_query()

        Readme.Repo.delete_all(query)

        {:ok, account}
      end,
      prepend?: true
    )
  end
end
