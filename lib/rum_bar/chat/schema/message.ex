defmodule RumBar.Chat.Schema.Message do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  alias RumBar.Profile.Schema.User
  alias RumBar.Chat.Schema.Thread

  defenum Type, text: 0, image_url: 1

  schema "messages" do
    field :content, :string
    field :type, Type

    belongs_to :sender, User
    belongs_to :receiver, User
    belongs_to :thread, Thread

    timestamps()
  end

  def chageset(message, attrs) do
    message
    |> cast(attrs, [:content, :type])
    |> validate_required([:content, :type])
  end
end