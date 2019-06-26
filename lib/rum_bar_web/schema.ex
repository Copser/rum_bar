defmodule RumBar.Schema do
  use Absinthe.Schema
  import_types RumBar.Schema.ContentTypes
  import_types RumBar.Schema.InputTypes
  import_types RumBar.Schema.Mutations

  query do
    field :me, :viewer do
      resolve fn (_, _, %{context: %{viewer: viewer}}) ->
        {:ok, viewer}
      end
    end
  end

  mutation do
    import_fields :mutations
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

  def middleware(middleware, _field, _object), do: middleware
end