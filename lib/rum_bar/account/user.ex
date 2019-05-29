defmodule RumBar.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profile" do
    field :email, :string
    field :name, :string
    field :password_hash, :string

    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6)
    |> update_change(:email, &String.trim/1)
    |> update_change(:email, &String.downcase/1)
    |> hash_password()
  end

  def create_changeset(account, attrs) do
    account
    |> changeset(attrs)
    |> validate_required([:password])
  end

  def has_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset
end
