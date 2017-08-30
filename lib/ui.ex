defmodule ExploringMars.UI do
  def start(), do: go()

  defp go() do
    IO.gets("What the map size:\n")
    |> String.trim
    |> String.split([",", " "])
    |> go
  end

  defp go({:ok, _, matrix_size}) do
    initial_probe_state = IO.gets("Where is the next probe:\n")
    |> String.trim
    |> String.split([",", " "])

    result = IO.gets("Waiting instructions for probe:\n")
    |> String.trim
    |> String.split("", trim: true)
    |> ExploringMars.main(initial_probe_state, matrix_size)

    {_, %ExploringMars.Probe{x_position: x, y_position: y, cardinal: c }, _} = result
    IO.puts("#{x} #{y} #{c}")

    go(result)
  end

  defp go(matrix_size), do: go({:ok, %{}, matrix_size})

end
