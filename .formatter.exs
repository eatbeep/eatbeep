[
  import_deps: [:ecto, :phoenix, :ash,
  :ash_postgres,
  :ash_policy_authorizer,
  :surface
  ],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"]
]
