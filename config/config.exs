# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rum_bar,
  ecto_repos: [RumBar.Repo]

config :rum_bar, RumBar.Repo,
  migration_primary_key: [name: :id, type: :binary_id]

# Configures the endpoint
config :rum_bar, RumBarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PrI2bX8nYTz2cZ+9X7R/Vd0Y+YpRIkXoQuLr0COxqjnfoRBCHof5yTmMBU4ZU3ei",
  render_errors: [view: RumBarWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RumBar.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Joken Token config
config :joken, default_signer: [
  signer_alg: "HS256",
  key_octet: "cuastv23dsqwdffnhjhdbkcbakjasqkfwir123o8r83bufbfbf1b"
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
