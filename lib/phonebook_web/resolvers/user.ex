defmodule PhonebookWeb.Resolvers.User do

  @moduledoc false

  alias Phonebook.Account

  def all(params, _) do
    update_process_state("all_users")

    result = Account.all_users(params)
    {:ok, result}
  end

  def find(%{id: id} = _params, _) do
    id = String.to_integer(id)
    update_process_state("find_user")
    Account.find_user(%{id: id})
  end

  def update(%{id: id} = params, _) do
    update_process_state("update_user")
    id = String.to_integer(id)
    Account.update_user(id, Map.delete(params, :id))
  end

  @spec create_user(any, any) :: {:error, %{optional(atom) => [any]}} | {:ok, any}
  def create_user(params, _) do
    update_process_state("create_user")
    Account.create_user(params)
  end

  def update_preferences(params, _) do
    update_process_state("update_preferences")
    %{user_id: user_id} = params
    Account.update_user_preferences(String.to_integer(user_id), Map.delete(params, :user_id))
  end

  defp update_process_state(key) do
    Phonebook.ResolverCounter.increment_by_one(key)
  end
end
