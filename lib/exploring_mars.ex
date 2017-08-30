defmodule ExploringMars do
  @moduledoc """
  E: 0
  N: 90
  W: 180
  S: 360
  """
  alias ExploringMars.Probe

  def main(instructions, probe_position, matrix_size) do
    matrix_size = if String.valid?(List.first(matrix_size)), do: Enum.map(matrix_size, &(String.to_integer(&1))), else: matrix_size

    [probe_position_x, probe_position_y, probe_cardinal] = probe_position

    probe = %Probe{
      x_position: if(String.valid?(probe_position_x), do: String.to_integer(probe_position_x), else: probe_position_x),
      y_position: if(String.valid?(probe_position_y), do: String.to_integer(probe_position_y), else: probe_position_y),
      cardinal: String.to_atom(probe_cardinal)
    }

    next_probe_position = instructions
    |> Enum.map(
        fn(i) ->
          String.upcase(i) |> String.to_atom
        end
      )
    |> process_instructions(probe, matrix_size)

    {:ok, next_probe_position, matrix_size}
  end

  def process_instructions(instructions, probe, matrix_size) do
    instructions
    |> Enum.chunk_by(&(&1 == :M))
    |> Enum.reduce(probe,
      fn(x, acc) ->
        cond do
          List.first(x) == :M ->
            calculate_instruction([[], x], acc)
            |> calculate_next_position
          true ->
            calculate_instruction([x, []], acc)
            |> calculate_next_position
        end
      end
    )
  end

  def calculate_instruction([dir, moves], probe) do
    current_degrees = Enum.reduce(dir, cardinal_to_degrees(probe.cardinal),
      fn (d, acc) ->
        direction_to_degrees(d) + acc
      end
    )

    {:ok, current_degrees, length(moves), probe}
  end

  def calculate_next_position({:ok, degrees, moves, probe}), do: calculate_next_position(degrees, moves, probe)
  def calculate_next_position(degrees, moves, probe) do
    x = :math.cos(degrees / (180 / :math.pi))
    |> :erlang.float_to_binary([:compact, { :decimals, 0 }])
    |> String.to_integer

    y = :math.sin(degrees / (180 / :math.pi))
    |> :erlang.float_to_binary([:compact, { :decimals, 0 }])
    |> String.to_integer

    %Probe{
      x_position: probe.x_position + (x * moves),
      y_position: probe.y_position + (y * moves),
      cardinal: degrees_to_cardinal([x, y])
    }
  end

  def cardinal_to_degrees(cardinal) do
    case cardinal do
      :E -> 0
      :N -> 90
      :W -> 180
      :S -> 270
      _ -> {:error, :unknown_cardinal_point}
    end
  end

  def degrees_to_cardinal(degrees) do
    case degrees do
      [1, 0] -> :E
      [0, 1] -> :N
      [-1, 0] -> :W
      [0, -1] -> :S
      _ -> {:error, :unknown_degree}
    end
  end

  def direction_to_degrees(dir) do
    case dir do
      :L -> 90
      :R -> -90
      _ -> {:error, :unknown_direction}
    end
  end

end
