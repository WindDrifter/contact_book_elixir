defmodule Phonebook.Account.Preference do
  @type preference :: %__MODULE__{
    likes_emails: boolean(),
    likes_phone_calls: boolean()
  }

  use Ecto.Schema
  import Ecto.Changeset

  schema "preferences" do
    field(:likes_emails, :boolean, default: false)
    field(:likes_phone_calls, :boolean, default: false)
    has_one(:user, Phonebook.Account.User)
  end

  @available_fields [:likes_emails, :likes_phone_calls]
  def create_changeset(params) do
    changeset(%Phonebook.Account.Preference{}, params)
  end

  @doc false
  def changeset(preference, attrs) do
    preference
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
  end
end
