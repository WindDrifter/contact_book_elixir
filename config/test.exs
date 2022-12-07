import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phonebook, PhonebookWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :phonebook, Phonebook.Repo,
  database: "phonebook_repo_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool: Ecto.Adapters.SQL.Sandbox
