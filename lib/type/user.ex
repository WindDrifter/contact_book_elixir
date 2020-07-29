defmodule PhonebookWeb.Types.User do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  @desc "Whether user love to contact via email or phone"
  object :contract_preferences do
    field :id, :id
    field :user_id, :id
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
  end

  input_object :contract_preferences_input do
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
  end

  @desc "A user"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :preference, :contract_preferences, resolve: dataloader(Phonebook.Account, :preference)
  end

end
