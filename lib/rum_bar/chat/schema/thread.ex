defmodule RumBar.Chat.Schema.Thread do
  use RumBar.Schema
  import Ecto.Changeset

  alias RumBar.Profile.Schema.User

  schema "threads" do
    field :headline, :string
    belongs_to :primo, User
    belongs_to :secundo, User

    timestamps()
  end

  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:headline])
  end
end
