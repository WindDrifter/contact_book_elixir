defmodule PhonebookWeb.SubcriptionCase do
  use ExUnit.CaseTemplate
  using do
    quote do
      use PhonebookWeb.ChannelCase
      use Absinthe.Phoenix.SubscriptionTest,
        schema: PhonebookWeb.Schema
      setup do
        {:ok, socket} = Phoenix.ChannelTest.connect(PhonebookWeb.UserSocket, %{})
        {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)

        {:ok, %{socket: socket}}

      end
    end
  end
end
