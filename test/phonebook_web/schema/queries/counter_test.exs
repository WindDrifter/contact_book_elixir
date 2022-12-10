defmodule PhonebookWeb.Schema.Queries.CounterTest do
  # I disable async for accurate result
  use Phonebook.DataCase
  alias PhonebookWeb.Schema

  @all_users_doc """
    query AllUsers($likes_emails: Boolean, $likes_phone_calls: Boolean, $first: Int){
      users(likesEmails: $likes_emails, likesPhoneCalls: $likes_phone_calls, first: $first) {
        id
        name
        email
      }
    }
  """
  @get_current_count_doc """
    query getCount($key: String){
      resolverHits(key: $key){
        name
        count
      }
    }
  """

  describe "@resolverHits" do
    test "ensure count is getting updated when other docs ran" do
      # Need to get current state for comparing result
      {:ok, current_state} = Phonebook.ResolverCounter.get_current_count_by_key("all_users")
      current_all_users_count = current_state || 0

      assert {:ok, _} =
               Absinthe.run(@all_users_doc, Schema,
                 variables: %{
                   "likes_phone_calls" => false
                 }
               )

      assert {:ok, %{data: data}} =
               Absinthe.run(@get_current_count_doc, Schema, variables: %{"key" => "all_users"})

      expected_count = current_all_users_count + 1
      assert data["resolverHits"]["count"] === expected_count
    end

    test "get default value of 0 even if the key should not exist" do
      assert {:ok, %{data: data}} =
               Absinthe.run(@get_current_count_doc, Schema, variables: %{"key" => "bogus"})

      assert data["resolverHits"]["count"] === 0
    end
  end
end
