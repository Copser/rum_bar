defmodule RumBar.Schema do
  use Absinthe.Schema

  query do
    field :me, :user do
      resolve fn (_, _, %{context: %{user: user}}) ->
        {:ok, user}
      end
    end
  end

  def mutations do
    import_fields :mutations
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(RumBar.Repo)

    loader =
      Dataloader.new
      |> Dataloader.add_source(:db, source)

    user = ctx[:user] || RumBar.Repo.get!(RumBar.Account.User, 1)

    ctx
    |> Map.put(:loader, loader)
    |> Map.put(:user, user)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _field, %{indetifier: :mutation}) do
    middleware ++ [RumBar.Schema.ErrorMiddleware]
  end

  def middleware(middleware, _field, _object), do: middleware
end