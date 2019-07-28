defmodule RumBar.Chat do
  defdelegate send_message(viewer, args), to: RumBar.Chat.Actions.Message
  defdelegate find_or_create_thread(viewer, id), to: RumBar.Chat.Actions.Message
end
