defmodule Eatbeep.Repo do
  use Ecto.Repo,
    otp_app: :eatbeep,
    adapter: Ecto.Adapters.Postgres
end
