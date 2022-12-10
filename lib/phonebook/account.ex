defmodule Phonebook.Account do
  alias Phonebook.Account.User
  alias EctoShorts.Actions

  @spec all_users(map) :: list(User.t())
  def all_users(params \\ %{}) do
    # Have to split the params map due to 2 keys are for preference
    # otherwise the preference will not be search
    {preferences, params} = Map.split(params, [:likes_emails, :likes_phone_calls])
    # Have to use User.join_preferences() as accumulator
    # otherwise unbind error will be thrown
    query = Enum.reduce(preferences, User.join_preferences(), &convert_field_to_query/2)
    Actions.all(query, params)
  end

  defp convert_field_to_query({:likes_emails, value}, query) do
    User.by_likes_emails(query, value)
  end

  defp convert_field_to_query({:likes_phone_calls, value}, query) do
    User.by_likes_phone_calls(query, value)
  end

  # @spec find_user(map()) :: {:ok, User.t()}
  # def find_user(params \\ %{}) do
  #   Actions.find(User, params)
  # end

  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  @spec create_user(any) :: {:error, User.t()} | {:ok, User.t()}
  def create_user(params) do
    Actions.create(User, params)
  end

  def update_user_preferences(id, params) do
    with {:ok, schema} <- Actions.update(User, id, %{preference: params}) do
      format_result(schema)
    end
  end

  defp format_result(schema) do
    schema.preference
    |> Map.from_struct()
    |> Map.put_new(:user_id, schema.id)
    |> then(& {:ok, &1})
  end
end
