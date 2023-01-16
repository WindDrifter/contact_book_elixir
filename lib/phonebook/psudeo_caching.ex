defmodule Phonebook.PsudeoCaching do
  use GenServer
  @default_name Phonebook.PsudeoCaching

  def start_link(opts \\ [])
  def start_link({name, opts}) do
    table = :ets.new(name, opts)
    GenServer.start_link(__MODULE__, %{table: table}, name: @default_name)
  end

  def start_link(opts) do
    start_link({@default_name, opts})
  end

  def init(_) do
    {:ok, nil}
  end
end
