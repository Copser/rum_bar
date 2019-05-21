defmodule RumBar.Repo.Migrations.CreateProfile do
  use Ecto.Migration

  def change do
    create table(:profile) do
      add :name, :string
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

  end
end
