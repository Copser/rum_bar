defmodule RumBar.Repo do
  use Ecto.Repo, otp_app: :rum_bar, adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 10
  import Ecto.Query

  def first(query) do
    query
    |> order_by(asc: :id)
    |> limit(1)
    |> RumBar.Repo.one
  end
end
