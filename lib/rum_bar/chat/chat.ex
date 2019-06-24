defmodule RumBar.Chat do
  defdelegate send_message(viewer, args), to: RumBar.Chat.Actions.Message
end