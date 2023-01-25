defmodule PhonebookWeb.Schema do
  use Absinthe.Schema

  import_types(PhonebookWeb.Types.User)
  import_types(PhonebookWeb.Types.Counter)
  import_types(PhonebookWeb.Schema.Queries.User)
  import_types(PhonebookWeb.Schema.Queries.Counter)
  import_types(PhonebookWeb.Schema.Mutations.User)
  import_types(PhonebookWeb.Schema.Subscriptions.User)
  alias PhonebookWeb.Middleware.HandleError
  query do
    import_fields(:user_queries)
    import_fields(:counter_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end

  subscription do
    import_fields(:user_subscriptions)
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(Phonebook.Repo)
    dataloader = Dataloader.add_source(Dataloader.new(), Phonebook.Account, source)

    Map.put(ctx, :loader, dataloader)
  end

  def middleware(middleware, _field, %{identifier: identifier} = _object)
      when identifier in [:mutation, :query] do
    middleware ++ [HandleError]
  end

  def middleware(middleware, _, _) do
    middleware
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
