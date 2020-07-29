defmodule PhonebookWeb.Schema.Queries.User do
  use Absinthe.Schema.Notation
  alias PhonebookWeb.Resolvers

  object :user_queries do
    field :user, :user do
      arg :id, non_null(:id)
      arg :names, list_of(:string)
      resolve &Resolvers.User.find/2
    end
    field :users, list_of(:user) do
      arg :likes_emails, :boolean
      arg :likes_phone_calls, :boolean
      arg :first, :integer
      arg :before, :integer
      arg :after, :integer
      arg :name, :string
      resolve &Resolvers.User.all/2
    end
  end
end
