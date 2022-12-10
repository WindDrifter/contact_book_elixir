defmodule Phonebook.Account.User do
  @moduledoc false
  @type t :: %__MODULE__{
    email: String.t(),
    name: String.t()
  }
  @type t_res() :: {:ok, t()} | {:error, any()}
  import Ecto.Changeset
  import Ecto.Query
  use Ecto.Schema
  alias EctoShorts.CommonChanges

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    belongs_to(:preference, Phonebook.Account.Preference, on_replace: :update)
  end

  @required_fields [:email, :name]
  @available_fields [:id, :preference_id | @required_fields]

  @spec join_preferences(any) :: Ecto.Query.t()
  def join_preferences(query \\ Phonebook.Account.User) do
    join(query, :inner, [u], p in assoc(u, :preference), as: :preference)
  end

  def by_likes_emails(query \\ join_preferences(), likes_emails) do
    where(query, [preference: p], p.likes_emails == ^likes_emails)
  end

  def by_likes_phone_calls(query \\ join_preferences(), likes_phone_calls) do
    where(query, [preference: p], p.likes_phone_calls == ^likes_phone_calls)
  end

  def create_changeset(params) do
    changeset(%Phonebook.Account.User{}, params)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> Phonebook.Repo.preload(:preference)
    |> cast(attrs, @available_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> CommonChanges.preload_change_assoc(:preference)
  end
end
