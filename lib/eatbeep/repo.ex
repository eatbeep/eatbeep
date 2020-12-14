defmodule Eatbeep.Repo do
  use AshPostgres.Repo,
    otp_app: :eatbeep,
    adapter: Ecto.Adapters.Postgres
end
