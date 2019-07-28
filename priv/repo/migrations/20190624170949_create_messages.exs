defmodule RumBar.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
      create table(:messages) do
        add :content, :string
        add :type, :integer, null: false

        add :cursor, :string, null: false

        add :sender_id, references(:users, on_delete: :delete_all)
        add :receiver_id, references(:users, on_delete: :delete_all)
        add :thread_id, references(:threads, on_delete: :delete_all)

        timestamps()
      end

      create index(:messages, [:thread_id])
      create index(:messages, [:cursor])

  end
end

