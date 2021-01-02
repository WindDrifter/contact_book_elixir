defmodule PhonebookWeb.Middleware.HandleError do
  require IEx
  @behaviour Absinthe.Middleware
  def call(resolution, _) when resolution.errors != [] do
      errors = Enum.flat_map(resolution.errors, &handle_error/1)
      errors = Phonebook.ErrorUtils.format_errors(errors)
      Absinthe.Resolution.put_result(resolution, errors)
  end
  def call(resolution, _) when resolution.errors === [] do
    resolution
  end
  defp handle_error(%Ecto.Changeset{} = changeset) do
    changeset
      |> Ecto.Changeset.traverse_errors(fn {err, _opts} -> err end)
      |> Enum.map(fn({k,v}) ->  {:message, "#{k}: #{v}"} end)
      |> Keyword.put(:code, :conflict)
  end
  defp handle_error(errors) do
    errors
  end

end
