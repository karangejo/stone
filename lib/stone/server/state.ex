defmodule Stone.Server.State do

  defstruct [
     :bpm,
     :num_bars,
     :time_signature,
     :scale,
     :root,
     :midi_out,
     :code,
  ]

end
