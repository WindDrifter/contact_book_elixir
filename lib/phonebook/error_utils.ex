defmodule Phonebook.ErrorUtils do
  def format_errors(errors) do
    case errors[:code] do
      :conflict -> conflict(errors)
      _ -> check_error(errors)
    end
  end

  def check_error([_error | _] = _errors) do
    internal_server_error_found()
  end

  defp conflict(errors) do
    {:error, %{code: :conflict, message: errors[:message]}}
  end

  def internal_server_error_found() do
    {:error, %{code: :internal_server_error, message: "Something went wrong in our end"}}
  end
end
