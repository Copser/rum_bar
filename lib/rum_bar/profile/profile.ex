defmodule RumBar.Profile do
  alias RumBar.Profile.Action

  defdelegate get!(id), to: Action.User
end