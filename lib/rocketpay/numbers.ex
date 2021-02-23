defmodule Rocketpay.Numbers do
  def sum_from_files(filename) do
    "#{filename}.csv"
      |> File.read()
      |> handle_file()
  end

  defp handle_file({:ok, file}) do
    result = result
      |> String.split("")
      |> Stream.map(fn number -> String.to_integer(number) end)
      |> Enum.sum()

    {:ok, %{result: result}}
  end

  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid file!"}}
end
