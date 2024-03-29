defmodule PhonebookWeb.Schema.Mutations.UserTest do
  use Phonebook.DataCase, async: true

  alias PhonebookWeb.Schema
  alias Phonebook.Account
  alias Phonebook.Account.Preference
  alias Phonebook.Support.UserSupport
  alias EctoShorts.Actions

  @create_user_doc """
    mutation CreateUser($name: String, $email: String, $preference: ContractPreferencesInput){
      createUser(name: $name, email: $email, preference: $preference) {
        id
        name
        email
      }
    }
  """
  @update_user_doc """
    mutation UpdateUser($id: ID!, $name: String, $email: String){
      updateUser(id: $id, name: $name, email: $email) {
        id
        name
        email
      }
    }
  """
  @update_user_pref_doc """
    mutation UpdateUserPreference($id: ID!, $likes_emails: Boolean, $likes_phone_calls: Boolean){
      updateUserPreferences(userId: $id, likesEmails: $likes_emails, likesPhoneCalls: $likes_phone_calls) {
        userId
        likesEmails
      }
    }
  """

  def setup_user(context) do
    {_, user} = UserSupport.generate_user()
    Map.put(context, :id, user.id)
  end

  describe "@create_user" do
    test "able to create user" do
      assert {:ok, %{data: _data}} =
               Absinthe.run(@create_user_doc, Schema,
                 variables: %{
                   "email" => "test@test.com",
                   "name" => "name1",
                   "preference" => %{"likes_emails" => true, "likes_phone_calls" => true}
                 }
               )

      {:ok, user} = Account.find_user(%{email: "test@test.com"})
      assert user.name === "name1"
    end

    test "not able to create user with same email" do
      new_user = %{
        "email" => "test@test.com",
        "name" => "name1"
      }

      assert {:ok, _user} = Account.create_user(new_user)

      assert {:ok, %{errors: errors}} =
               Absinthe.run(@create_user_doc, Schema,
                 variables: %{
                   "email" => "test@test.com",
                   "name" => "name1",
                   "preference" => %{"likes_emails" => true, "likes_phone_calls" => true}
                 }
               )

      [first_error | _] = errors
      assert first_error.code === :conflict
    end

    test "return errors if at least one important params is missing" do
      assert {:ok, %{errors: [%{message: err_message}]}} =
               Absinthe.run(@create_user_doc, Schema,
                 variables: %{
                   "email" => "test@test.com",
                   "preference" => %{"likes_emails" => true, "likes_phone_calls" => true}
                 }
               )

      assert err_message =~ "found null"
    end
  end

  describe "@update_user" do
    setup [:setup_user]

    test "able to update user", context do
      id = to_string(context[:id])

      assert {:ok, %{data: _data}} =
               Absinthe.run(@update_user_doc, Schema,
                 variables: %{
                   "id" => id,
                   "email" => "update_email@email.com",
                   "name" => "new_name"
                 }
               )

      assert {:ok, %{email: "update_email@email.com", name: "new_name"}} =
               Account.find_user(%{id: id})
    end
  end

  describe "@update_preferences" do
    setup [:setup_user]

    test "able to update user pref", context do
      id = to_string(context[:id])

      assert {:ok, %{data: _data}} =
               Absinthe.run(@update_user_pref_doc, Schema,
                 variables: %{
                   "id" => id,
                   "likes_emails" => true,
                   "likes_phone_calls" => true
                 }
               )

      assert {:ok, user2} = Account.find_user(%{id: id})
      assert {:ok, user_pref} = Actions.find(Preference, id: user2.preference_id)
      assert user_pref.likes_phone_calls
    end

    test "return error if id doesn't exist ", context do
      id = to_string(context[:id] + 1)

      assert {:ok, %{errors: errors}} =
               Absinthe.run(@update_user_pref_doc, Schema,
                 variables: %{
                   "id" => id,
                   "likes_emails" => true,
                   "likes_phone_calls" => true
                 }
               )

      assert [%{code: :not_found} | _] = errors
    end
  end
end
