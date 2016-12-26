# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :push_api_server,
  ecto_repos: [PushAPIServer.Repo]

# Configures the endpoint
config :push_api_server, PushAPIServer.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QQzJMYhQ6VJYsWlzMp3bAi6bBVDKnGATVOzPNsOdKEKUwnMZCDQN6Iu0LAK9gg96",
  render_errors: [view: PushAPIServer.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PushAPIServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
