defmodule RumBar.Schema.Mutations do
  use Absinthe.Schema.Notation

  alias RumBar.Profile.Action.User
  alias RumBar.Chat

  object :mutations do

    field :login, type: :login_result do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve fn _, args, _ ->
        case RumBar.Auth.login(args.email, args.password) do
          {:ok, %{user: user, token: token}} -> {:ok, %{token: token, ok: true}}
          t -> t
        end
      end
    end

    field :update_profile, type: :user do
      arg :user, :profile_input

      resolve fn _, %{user: user}, %{context: %{viewer: viewer}}->
        User.update_profile(viewer, user)
      end
    end

    field :register_user, type: :user do
      arg :name, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve fn _, args, _ ->
        User.register_user(args)
      end
    end

    field :send_message, type: :message do
      arg :content, non_null(:string)
      arg :receiver_id, non_null(:id)
      arg :type, non_null(:integer)

      resolve fn _, args, %{context: %{viewer: viewer}} ->
        Chat.send_message(viewer, args)
      end
    end
  end
end