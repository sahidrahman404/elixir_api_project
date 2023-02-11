import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :readme, ReadmeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "z03CGM1G1Vm8vYzmKLbkqMcQNfXNIhqg5QVMkmoXxmrrftJCSQzNdZtFFuEAyWoE",
  server: false

# In test we don't send emails.
config :readme, Readme.Mailer,
  adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

#Ecto
config :readme, Readme.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "helpdesk_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10
