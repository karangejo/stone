defmodule Stone.Parser do
  import NimbleParsec

  alias Stone.StoneNote

  def convert_note(_rest, args, context,_line, _offset) do
    [note, duration, volume] = args
    {[%StoneNote{note: note, duration: duration, volume: volume}], context}
  end

  note =
    integer([min: 0, max: 255])
    |> ignore(string("d"))
    |> integer([min: 0, max: 255])
    |> ignore(string("v"))
    |> integer([min: 0, max: 255])
    |> post_traverse(:convert_note)

  comma_note =
    ignore(string(","))
    |> concat(note)

  notes =
    note
    |> times(comma_note, min: 0)
    |> eos()

  defparsec(:notes, notes)
end
