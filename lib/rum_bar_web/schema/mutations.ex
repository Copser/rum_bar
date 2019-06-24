defmodule RumBar.Schema.Mutations do
  use Absinthe.Schema.Notation
  alias RumBar.Account
  alias RumBar.Chat

  object :mutations do

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

    field :update_profile, type: :user do
      arg :id, :id

      resolve fn _, %{id: id}, %{context: %{viewer: viewer}}->
        Profile.update_profile(id, viewer)
      end
    end

    field :send_message, type: :string do
      arg :content, non_null(:string)
      arg :receiver_id, non_null(:string)
      arg :type, non_null(:integer)

      resolve fn _, args, %{context: %{viewer: viewer}} ->
        Chat.send_message(viewer, args)
      end
    end
  end
end