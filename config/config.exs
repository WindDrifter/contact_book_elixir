# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :phonebook, Phonebook.Repo,
  database: "phonebook_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :phonebook,
  ecto_repos: [Phonebook.Repo]

config :ecto_shorts,
  repo: Phonebook.Repo,
  error_module: EctoShorts.Actions.Error

# Configures the endpoint
config :phonebook, PhonebookWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EIBEYgDQS0Qdh3NSKi2CgkkvYPRxq3s+TNoY0IIi0cKAJNlv9AfFQV9s1jRSGDr1",
  render_errors: [view: PhonebookWeb.ErrorView, accepts: ~w(json)],
  pubsub_server: Phonebook.PubSub,
  live_view: [signing_salt: "6VyQ7uPb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
