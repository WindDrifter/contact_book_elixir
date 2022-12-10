defmodule PhonebookWeb.Types.Counter do
  use Absinthe.Schema.Notation

  object :resolver_counter do
    field(:name, :string)
    field(:count, :integer)
  end
end
