defmodule RumBar.Chat.Schema.Message do
  use RumBar.Schema
  import Ecto.Changeset
  import EctoEnum

  alias RumBar.Profile.Schema.User
  alias RumBar.Chat.Schema.Thread

  defenum Type, text: 0, image_url: 1

  schema "messages" do
    field :content, :string
    field :cursor, :string
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
    |> put_cursor
  end

  def put_cursor(changeset) do
    if get_field(changeset, :cursor) != nil do
      changeset
    else
      changeset
      |> put_change(:cursor, generate_cursor())
    end
  end

  def generate_cursor do
    com_a = :os.system_time(:nanosecond)
    com_b = Enum.random(10000..99999)

    (:binary.encode_unsigned(com_a) <> :binary.encode_unsigned(com_b))
    |> Base.encode16
  end
end
