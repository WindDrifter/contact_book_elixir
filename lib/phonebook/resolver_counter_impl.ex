defmodule Phonebook.ResolverCounter.Impl do
  def key_incrementor(state, key) do
    Map.update(state, key, 1, & &1 + 1)
  end

  def get_resolver_count(key) do
    {_, result} = Phonebook.ResolverCounter.get_current_count_by_key(key)

    {:ok,
     %{
       name: key,
       count: result
     }}
  end
end
