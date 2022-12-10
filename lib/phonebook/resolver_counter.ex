defmodule Phonebook.ResolverCounter do
  use Agent
  @default_name Phonebook.ResolverCounter

  def start_link(opts \\ []) do
    initial_state = %{}
    opts = Keyword.put_new(opts, :name, @default_name)
    Agent.start_link(fn -> initial_state end, opts)
  end

  def increment_by_one(name \\ @default_name, key) do
    Agent.update(name, fn state -> Phonebook.ResolverCounter.Impl.key_incrementor(state, key) end)
  end

  def get_current_count_by_key(name \\ @default_name, key) do
    Agent.get(name, fn state -> {:ok, Map.get(state, key) || 0} end)
  end

  def get_current_state(name \\ @default_name) do
    Agent.get(name, fn state -> {:ok, state} end)
  end

  def erase_state(name \\ @default_name) do
    Agent.update(name, fn _state -> %{} end)
  end
end
