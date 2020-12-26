# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :eatbeep,
  ecto_repos: [Eatbeep.Repo]

# Configures the endpoint
config :eatbeep, EatbeepWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nRUoLlPCJZn5BTYUtkOYbPLtLUmLL0NVyZYaHsO2uicVPPDQKzQdl/SYxlurBStr",
  render_errors: [view: EatbeepWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Eatbeep.PubSub,
  live_view: [signing_salt: "49tikfQm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :surface, :components, [
  {Surface.Components.Form.ErrorTag, default_class: "field-error"}
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
