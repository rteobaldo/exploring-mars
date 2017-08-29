defmodule ExploringMars.UI do
  def start(), do: go()

  defp go() do
    IO.gets("What map size (Ex: 5 5):\n")
    |> String.trim
    |> String.split([",", " "])
    |> go
  end

  defp go(matrix_size) do
    initial_probe_state = IO.gets("Where is the next probe:\n")
    |> String.trim
    |> String.split([",", " "])

    IO.gets("Waiting instructions for probe:\n")
    |> String.trim
    |> String.split([",", " "])
    |> ExploringMars.main(initial_probe_state, matrix_size)
    |> go
  end

end
