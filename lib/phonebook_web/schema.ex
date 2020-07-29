defmodule PhonebookWeb.Schema do
  use Absinthe.Schema

  import_types PhonebookWeb.Types.User
  import_types PhonebookWeb.Types.Counter
  import_types PhonebookWeb.Schema.Queries.User
  import_types PhonebookWeb.Schema.Queries.Counter
  import_types PhonebookWeb.Schema.Mutations.User
  import_types PhonebookWeb.Schema.Subscriptions.User

  query do
    import_fields :user_queries
    import_fields :counter_queries
  end

  mutation do
    import_fields :user_mutations
  end

  subscription do
    import_fields :user_subscriptions
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(Phonebook.Repo)
    dataloader = Dataloader.add_source(Dataloader.new(), Phonebook.Account, source)

    Map.put(ctx, :loader, dataloader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
