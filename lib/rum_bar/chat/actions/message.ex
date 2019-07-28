defmodule RumBar.Chat.Actions.Message do
  import Ecto.Query
  import Ecto.Changeset

  alias __MODULE__
  alias RumBar.Repo
  alias RumBar.Chat.Schema.Thread
  alias RumBar.Chat.Schema.Message

  alias Ecto.Multi
  ## ACTION ##

  # removing int
  # def parse_int(val) when is_integer(val), do: val
  # def parse_int(val) do
  #   {val, _} = Integer.parse(val)
  #   val
  # end

  def send_message(viewer, %{content: content, type: type, receiver_id: id}) do
    thread = find_or_create_thread(viewer, id)
    type = type || "text"

    message_changeset =
      %Message{}
      |> Message.chageset(%{content: content, type: type})
      |> put_change(:receiver_id, id)
      |> put_change(:sender_id, viewer.id)
      |> put_change(:thread_id, thread.id)

    thread_changeset =
      thread
      |> Thread.changeset(%{headline: content})

    {:ok, %{message: message}} =
      Multi.new
      |> Multi.insert(:message, message_changeset)
      |> Multi.update(:thread, thread_changeset)
      |> Repo.transaction

    {:ok, Repo.preload(message, [:sender, :receiver])}
  end

  def find_or_create_thread(viewer, id) do
    thread =
      Thread
      |> where([t], (t.primo_id == ^viewer.id and t.secundo_id == ^id) or (t.secundo_id == ^viewer.id and t.primo_id == ^id))
      |> IO.inspect
      |> Repo.one

    if thread == nil do
      Repo.insert!(%Thread{primo_id: viewer.id, secundo_id: id})
    else
      thread
    end
  end

  ## QUERY ##

  def list_messages(_viewer, %{thread_id: thread_id} = params) do
    query =
      Message
      |> where([t], t.thread_id == ^thread_id)
      |> order_by(desc: :cursor)
      |> preload([:sender, :receiver])
      |> limit(10)

    query =
      if !params[:after], do: query, else: where(query, [t], t.cursor < ^params.after)

      {:ok, Repo.all(query)}
  end

  def list_threads(viewer, %{page: page, page_size: page_size}) do
    threads =
      Thread
      |> where([t], t.primo_id == ^viewer.id or t.secundo_id == ^viewer.id)
      |> order_by(desc: :updated_at)
      |> preload([:primo, :secundo])
      |> Repo.paginate(page: page, page_size: page_size)

    {:ok, threads}
  end
end
