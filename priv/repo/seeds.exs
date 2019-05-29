# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RumBar.Repo.insert!(%RumBar.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias RumBar.Repo
alias RumBar.Account.User

bob = %User{}
  |> User.create_changeset(%{ name: "Bob", email: "dev1@example.com", password: "123456"})
  |> Repo.insert!

alice = %User{}
  |> User.create_changeset(%{ name: "Alice", email: "dev2@example.com", password: "123456"})
  |> Repo.insert!

IO.inspect([bob, alice])
