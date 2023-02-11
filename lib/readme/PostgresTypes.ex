Postgrex.Types.define(
  Readme.PostgresTypes,
  [EctoLtree.Postgrex.Lquery, EctoLtree.Postgrex.Ltree] ++
    Ecto.Adapters.Postgres.extensions()
)
