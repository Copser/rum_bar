defmodule RumBar.Profile do
  alias RumBar.Profile.Action

  defdelegate get!(id), to: Action.User
  defdelegate get(id), to: Action.User

  defdelegate register_user(user_params), to: Action.User
  defdelegate update_profile(viewer, user_params), to: Action.User
end
