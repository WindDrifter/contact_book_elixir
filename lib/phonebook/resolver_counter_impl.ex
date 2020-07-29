defmodule Phonebook.ResolverCounter.Impl do
  def key_incrementor(state, key) do
    if Map.get(state, key) === nil do
      Map.put(state, key, 1)
    else
      Map.put(state, key, state[key] + 1)
    end
  end

  def get_resolver_count(key) do
    {_, result} = Phonebook.ResolverCounter.get_current_count_by_key(key)
    {:ok, %{
      name: key,
      count: result
    }}
  end


end
