defmodule Phonebook.AccountTest do
  use Phonebook.DataCase, async: true

  alias Phonebook.Account
  alias Phonebook.Support.UserSupport

  describe "&create user/1" do
    test "able to create user" do
      new_user = %{name: "test user", email: "test@test.com"}
      assert {:ok, _} = Account.create_user(new_user)
      assert user = Phonebook.Repo.get_by(Account.User, name: "test user")
      assert user.name === new_user[:name]
    end
    test "not able to create user with same email" do
      new_user = %{name: "test user", email: "test@test.com"}
      new_user2 = %{name: "test user2", email: "test@test.com"}
      assert {:ok, _} = Account.create_user(new_user)
      assert {:error, message} = Account.create_user(new_user2)
    end
    test "not able to create user if an important param is missing" do
      new_user = %{name: "test user"}
      assert {:error, _} = Account.create_user(new_user)
    end
  end
  describe "&find_user/1" do
    test "able to find user" do
      new_user = %{name: "test user", email: "test@test.com"}
      assert {:ok, _} = Account.create_user(new_user)
      assert {:ok, user} = Account.find_user(%{name: "test user"})
      assert user.name === new_user[:name]
    end
    test "return err if user dne" do
      new_user = %{name: "test user", email: "test@test.com"}
      assert {:ok, _} = Account.create_user(new_user)
      assert {:error, _} = Account.find_user(%{name: "nay"})
    end
  end
  describe "&update_user_pref/1" do
    test "able to update user pref" do
      assert {:ok, user} = UserSupport.generate_user
      assert {:ok, result} = Account.update_user_preferences(user.id, %{likes_emails: true, likes_phone_calls: true})
      assert result[:user_id] === user.id
      assert result[:likes_emails] === true
    end

  end


end
