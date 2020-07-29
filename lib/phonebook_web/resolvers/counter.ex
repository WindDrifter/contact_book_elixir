defmodule PhonebookWeb.Resolvers.Counter do

  def resolver_count(params, _) do
    %{key: key_name} = params
    Phonebook.ResolverCounter.Impl.get_resolver_count(key_name)
  end

end
