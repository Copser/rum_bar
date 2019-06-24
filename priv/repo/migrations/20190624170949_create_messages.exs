defmodule RumBar.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
      create table(:messages) do
        add :content, :string
        add :type, :integer, null: false
        add :sender_id, references(:users, on_delete: :delete_all)
        add :receiver_id, references(:users, on_delete: :delete_all)
        add :thread_id, references(:threads, on_delete: :delete_all)

        timestamps()
      end

      create index(:messages, [:content])
      create index(:messages, [:type])

      create unique_index(:messages, [:sender_id, :receiver_id, :thread_id])
  end
end

