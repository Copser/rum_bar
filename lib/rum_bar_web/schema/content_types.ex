defmodule RumBar.Schema.ContentTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :login_result do
    field :ok, :boolean
    field :token, :string
  end

  object :user do
    field :id, :id
    field :email, :string
    field :name, :string
  end

  object :viewer do
    field :id, :id
    field :email, :string
    field :name, :string
  end
end