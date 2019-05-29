defmodule RumBur.Account.Profile do
  alias RumBar.Account.User

  def update_profile(user, user_params) do
    user
    |> User.changeset(user_params)
    |> RumBar.Repo.update
  end
end