defmodule RumBar.Chat.Thread do
  use Ecto.Schema

  alias RumBar.Account.User

  schema "threads" do
    belongs_to :primo, User
    belongs_to :secundo, User

    timestamps()
  end
end