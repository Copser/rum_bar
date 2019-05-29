defmodule RumBar.Schema.InputTypes do
  use Absinthe.Schema.Notation

  input_object :profile_input do
    field :name, :string
    field :email, :string
    field :password, :string
  end
end