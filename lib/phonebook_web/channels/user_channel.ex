defmodule PhonebookWeb.UserChannel do
  use PhonebookWeb, :channel

  def join("users", _payload, socket) do
    {:ok, socket}
  end

  @spec handle_in(any, any, any) ::
          {:error, any} | {:noreply, nil, any} | {:reply, {:ok, map}, Phoenix.Socket.t()}
  def handle_in("new_user", %{"id" => id}, socket) do
    with :ok <- broadcast(socket, "new_user", %{"id" => id}) do
      {:reply, {:ok, %{"accepted" => true}}, socket}
    end
  end

  def handle_in(id, %{"user_id" => user_id}, socket) when id === user_id do
    # this if for update preferences check
    # it will boardcast certain user id update
    with :ok <- broadcast(socket, "update_preferences", %{"user_id" => user_id}) do
      {:reply, {:ok, %{"accepted" => true}}, socket}
    end
  end

  def handle_in(_, _, socket), do: {:noreply, nil, socket}
end
