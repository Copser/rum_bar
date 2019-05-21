defmodule RumBar.Repo do
  use Ecto.Repo,
    otp_app: :rum_bar,
    adapter: Ecto.Adapters.Postgres
end
