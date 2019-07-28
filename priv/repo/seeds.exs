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
alias RumBar.Profile.Schema.User

users = Enum.map(0..100, fn _ ->
  %User{}
  |> User.changeset(%{
      name: Faker.Name.name,
      email: Faker.Internet.email,
      password: "123456"
  })
  |> Repo.insert!
end)

# First user
first =
  List.first(users)
  |> User.changeset(%{email: "example1@example.com"})
  |> Ecto.Changeset.put_change(:id, "11111111-1111-1111-1111-111111111111")
  |> Repo.update!
  |> IO.inspect

users =
  users
  |> List.replace_at(0, first)

# Send Messages
user_ids =
  users
  |> Enum.take(4)
  |> Enum.map(&(&1.id))

Enum.map(0..1000, fn _ ->
  [a_id, b_id | _] = Enum.shuffle(user_ids)
  RumBar.Chat.Actions.Message.send_message(%{id: a_id}, %{receiver_id: b_id, content: Faker.Lorem.sentence(1..10), type: 0})
end)
