defmodule RumBar.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add :primo_id, references(:users, on_delete: :delete_all)
      add :secundo_id, references(:users, on_delete: :delete_all)

      add :headline, :string, default: nil
      timestamps()
    end

    create unique_index(:threads, [:primo_id, :secundo_id])
  end
end
