defmodule RumBar.Schema.ContentTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias RumBar.Profile
  alias RumBar.Chat.Actions.Message

  ## PROFILE OBJECTS ##

  object :viewer do
    field :id, :id
    field :email, :string
    field :name, :string

    field :messages, :message_page do
      arg :thread_id, :id
      arg :page, :integer, default_value: 1
      arg :page_size, :integer, default_value: 10

      resolve fn (viewer, args, _) -> Message.list_messages(viewer, args) end
    end

    field :threads, :thread_page do
      arg :page, :integer, default_value: 1
      arg :page_size, :integer, default_value: 10

      resolve fn (viewer, args, _) -> Message.list_threads(viewer, args) end
    end
  end

  object :login_result do
    field :ok, :boolean
    field :token, :string
  end

  object :user do
    field :id, :id
    field :email, :string
    field :name, :string
  end

  ## CHAT OBJECTS ##

  object :thread do
    field :id, :id
  end

  object :thread_page do
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer

    field :entries, list_of(:thread)
  end

  object :message do
    field :content, :string
  end

  object :message_page do
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer

    field :entries, list_of(:message)
  end
end