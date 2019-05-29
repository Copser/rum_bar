defmodule RumBar.Mutations do
  use Absinthe.Schema.Notation

  alias RumBar.Account
  object mutations do

    field :login, type: :login_result do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve fn _, args, _ ->
        case RumBar.Account.Auth.login(args.email, args.password) do
          {:ok, %{user: user, token: token}} -> {:ok, %{token: token, ok: true}}
          t -> t
        end
      end
    end
  end
end