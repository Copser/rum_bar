defmodule RumBar.Chat.Actions.Message do
  import Ecto.Query
  import Ecto.Changeset

  alias RumBar.Repo
  alias RumBar.Chat.Thread
  alias RumBar.Chat.Message


  def find_or_create_thread(viewer, id) do
    thread =
      Thread
      |> where([t], (t.primo_id == ^viewer.id and t.secundo_id == ^id) or (t.secundo_id == ^viewer.id and t.primo_id == ^id))
      |> Repo.one

    if thread == nil do
      Repo.insert!(%Thread{ primo_id: viewer.id, secundo_id: id})
    else
      thread
    end
  end

  def send_message(viewer, %{content: content, type: type, receiver_id: receiver_id}) do

    thread = find_or_create_thread(viewer, receiver_id)
    type = type || "text"

    %Message{}
    |> Message.chageset(%{content: content, type: type})
    |> put_change(:receiver, receiver_id)
    |> put_change(:thread, thread.id)
    |> Repo.insert
  end

  ## QUERY ##

  def list_messages(viewer, thread) do
    messages =
      Message
      |> where([t], t.thread_id == ^thread.id)
      |> order_by(desc: :id)
      |> Repo.all

    {:ok, messages}
  end

  def list_threads(viewer) do
    threads =
      Thread
      |> where([t], t.primo_id == ^viewer.id or t.secundo_id == ^viewer.id)
      |> order_by(desc: :updated_at)
      |> Repo.all

    {:ok, threads}
  end
end