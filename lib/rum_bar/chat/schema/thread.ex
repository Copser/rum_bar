defmodule RumBar.Chat.Schema.Thread do
  use Ecto.Schema

  alias RumBar.Profile.Schema.User

  schema "threads" do
    belongs_to :primo, User
    belongs_to :secundo, User

    timestamps()
  end
end