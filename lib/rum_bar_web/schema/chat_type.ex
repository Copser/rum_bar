defmodule RumBarWeb.Schema.ChatType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias RumBar.Chat

  object :thread do
    field :id, :id
    field :headline, :string

    field :participant, :user do
      resolve fn(%{primo: primo, secundo: secundo} = thread, _, %{context: %{viewer: viewer}}) ->
        participant = if primo.id == viewer.id, do: secundo, else: primo

        {:ok, participant}
      end
    end
  end

  object :thread_page do
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer

    field :entries, list_of(:thread)
  end

  object :message do
    field :id, :id
    field :content, :string
    field :sender, :user
    field :receiver, :user

    field :cursor, :string
  end

  object :message_page do
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer

    field :entries, list_of(:message)
  end

  # MUTATION
  object :chat_mutations do
    field :send_message, type: :message do
      arg :content, non_null(:string)
      arg :receiver_id, non_null(:id)
      arg :type, non_null(:integer)

      resolve fn (_, args, %{context: %{viewer: viewer}}) ->
        Chat.send_message(viewer, args)
      end
    end
  end
end
