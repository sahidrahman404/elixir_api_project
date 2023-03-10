# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :readme, ReadmeWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: ReadmeWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Readme.PubSub,
  live_view: [signing_salt: "JrXOEFXG"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :readme, Readme.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# API
config :readme,
  ash_apis: [Readme.Articles, Readme.Accounts, Readme.ArticlesComments]

# Ecto
config :readme,
  ecto_repos: [Readme.Repo]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
config :ash, :use_all_identities_in_manage_relationship?, false
config :readme, :token_signing_secret, System.fetch_env!("README_API_ASH")
config :ash, :utc_datetime_type, :datetime
