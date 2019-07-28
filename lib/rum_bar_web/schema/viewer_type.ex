defmodule RumBarWeb.Schema.ViewerType do
  use Absinthe.Schema.Notation

  alias RumBar.Chat.Actions.Message

  ## PROFILE OBJECTS ##

  object :viewer do
    field :id, :id
    field :email, :string
    field :name, :string

    field :messages, list_of(:message) do
      arg :thread_id, :id
      arg :after, :string, default_value: nil

      resolve fn (viewer, args, _) -> Message.list_messages(viewer, args) end
    end

    field :threads, :thread_page do
      arg :page, :integer, default_value: 1
      arg :page_size, :integer, default_value: 10

      resolve fn (viewer, args, _) -> Message.list_threads(viewer, args) end
    end
  end
end
