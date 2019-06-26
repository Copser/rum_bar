defmodule RumBar.Chat.Actions.Message do
  import Ecto.Query
  import Ecto.Changeset

  alias __MODULE__
  alias RumBar.Repo
  alias RumBar.Chat.Schema.Thread
  alias RumBar.Chat.Schema.Message

  ## ACTION ##

  def parse_int(val) when is_integer(val), do: val
  def parse_int(val) do
    {val, _} = Integer.parse(val)
    val
  end

  def send_message(viewer, %{content: content, type: type, receiver_id: id}) do
    id = parse_int(id)
    thread = find_or_create_thread(viewer, id)
    type = type || "text"

    %Message{}
    |> Message.chageset(%{content: content, type: type})
    |> put_change(:receiver, id)
    |> put_change(:thread, thread.id)
    |> Repo.insert
  end

  def find_or_create_thread(viewer, id) do
    id = parse_int(id)
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

  def list_messages(viewer, %{thread_id: thread_id, page: page, page_size: page_size}) do
    messages_page =
      Message
      |> where([t], t.thread_id == ^thread_id)
      |> order_by(desc: :id)
      |> Repo.paginate(page: page, page_size: page_size)

    {:ok, messages_page}
  end

  def list_threads(viewer, %{page: page, page_size: page_size}) do
    threads =
      Thread
      |> where([t], t.primo_id == ^viewer.id or t.secundo_id == ^viewer.id)
      |> order_by(desc: :updated_at)
      |> Repo.paginate(page: page, page_size: page_size)

    {:ok, threads}
  end
end