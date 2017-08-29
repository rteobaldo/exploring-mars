defmodule ExploringMars do
  @moduledoc """
  E: 0
  N: 90
  W: 180
  S: 360
  """
  alias ExploringMars.Probe

  def main(instructions, [probe_position_x, probe_position_y, probe_direction], matrix_size) do
    probe = %Probe{
      x_position: probe_position_x,
      y_position: probe_position_y,
      direction: cardinal_to_degrees(probe_direction)
    }

    # Enum.reduce(arr, last_direction,
    #   fn (x, acc) ->
    #     cond do
    #       (x + acc) > 360 -> x
    #       (x + acc) < -360 -> x
    #       true -> x + acc
    #     end
    #   end
    # )

    matrix_size
  end

  def run(instruction, probe_position, matrix_size) do

  end

  def cardinal_to_degrees(str) do
    case str do
      "E" -> 0
      "N" -> 90
      "W" -> 180
      "S" -> 360
      _ -> {:error, :unknown_direction}
    end
  end

end
