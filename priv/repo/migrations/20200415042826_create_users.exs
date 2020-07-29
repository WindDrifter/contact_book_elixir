defmodule Phonebook.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :text
      add :email, :text
      add :preference_id, references(:preferences, [on_update: :update_all, on_delete: :delete_all])

    end

    create unique_index(:users, [:email])
    create index(:users, [:preference_id])
  end
end
