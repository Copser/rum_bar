defmodule RumBar.Profile.Action.User do
  import Ecto.Changeset

  alias RumBar.Repo
  alias RumBar.Profile.Schema.User


  def get!(id) do
    Repo.get!(User, id)
  end

  def register_user(user_params) do
    %User{}
    |> User.create_changeset(user_params)
    |> Repo.insert
  end

  def update_profile(viewer, user_params) do
    viewer
    |> User.changeset(user_params)
    |> Repo.update
  end
end