defmodule RumBar.Schema do
  use Absinthe.Schema

  import Absinthe.Type.Custom
  import_types RumBarWeb.Schema.ProfileType
  import_types RumBarWeb.Schema.ChatType
  import_types RumBarWeb.Schema.ViewerType

  alias RumBar.Profile

  query do
    field :me, :viewer do
      resolve fn (_, _, %{context: %{viewer: viewer}}) ->
        {:ok, viewer}
      end
    end

    field :user, :user do
      arg :id, :id, default_value: "me"

      resolve fn _, %{id: id}, %{context: %{viewer: viewer}} ->
        id = if id == "me" do viewer.id else id end

        Profile.get(id)
    end
  end

  mutation do
    import_fields :profile_mutations
    import_fields :chat_mutations
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(RumBar.Repo)

    loader =
      Dataloader.new
      |> Dataloader.add_source(:db, source)

    viewer = ctx[:viewer] || RumBar.Repo.get!(RumBar.Profile.Schema.User, 1)

    ctx
    |> Map.put(:loader, loader)
    |> Map.put(:viewer, viewer)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _field, %{indetifier: :mutation}) do
    middleware ++ [RumBar.Schema.ErrorMiddleware]
  end

  def middleware(middleware, _field, _object), do: middleware end

end
