defmodule PhonebookWeb.Schema.Queries.Counter do
  use Absinthe.Schema.Notation
  alias PhonebookWeb.Resolvers

  object :counter_queries do
    field :resolver_hits, :resolver_counter do
      arg(:key, non_null(:string))
      resolve(&Resolvers.Counter.resolver_count/2)
    end
  end
end
