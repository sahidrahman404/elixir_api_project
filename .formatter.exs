[
  import_deps: [:ecto, :ecto_sql, :phoenix, :ash_postgres, :ash_authentication, 
    :ash_authentication_phoenix],
  subdirectories: ["priv/*/migrations"],
  inputs: ["*.{ex,exs}", "{config,lib,test}/**/*.{ex,exs}", "priv/*/seeds.exs"],
  line_length: 80
]
