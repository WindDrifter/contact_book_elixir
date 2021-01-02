defmodule Phonebook.ErrorUtils do

  def format_errors(errors) do
    case errors[:code] do
      :not_found -> not_found(errors)
      :conflict -> conflict(errors)
      _ -> check_error(errors)
    end

  end
  def check_error([_error|_] = _errors) do
    internal_server_error_found()
  end

  defp conflict(errors) do
    {:error, %{code: :conflict, message: errors[:message]}}
  end

  def not_found(errors) do
    table_name = errors[:query]
    |> to_string()
    |> String.split(".")
    |> List.last()
    id_not_found = errors[:details].params.id

    message = "#{table_name} with id: #{id_not_found} not found"
    {:error, %{message: message, code: errors[:code]}}
  end

  def internal_server_error_found() do
    {:error, %{code: :internal_server_error,
    message: "Something went wrong in our end"} }
  end
end
