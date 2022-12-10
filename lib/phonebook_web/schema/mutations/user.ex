defmodule PhonebookWeb.Schema.Mutations.User do
  use Absinthe.Schema.Notation

  object :user_mutations do
    @desc "Update a user's name or email"

    field :update_user, :user do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:email, :string)
      resolve(&PhonebookWeb.Resolvers.User.update/2)
      middleware(PhonebookWeb.Middleware.HandleError)
    end

    @desc "Create a new user and its preferences, by default both preferences are set to false. Id is auto generated"
    field :create_user, :user do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:preference, non_null(:contract_preferences_input))
      resolve(&PhonebookWeb.Resolvers.User.create_user/2)
      middleware(PhonebookWeb.Middleware.HandleError)
    end

    @desc "Update a user preferences"

    field :update_user_preferences, :contract_preferences do
      arg(:user_id, non_null(:id))
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      resolve(&PhonebookWeb.Resolvers.User.update_preferences/2)
    end
  end
end
