defmodule Stone.Midi do
  @moduledoc """
  Documentation for `Midi`.
  """
  alias PortMidi.Device
  alias Stone.Note

  def list_devices do
    dev_list = PortMidi.devices()
    %{input: get_device_names(dev_list.input), output: get_device_names(dev_list.output)}
  end

  def get_device_names(dev_list) do
    Enum.map(dev_list, fn %Device{} = x ->
      x.name
    end)
  end

  def connect_to_device(dev_name) do
    case PortMidi.open(:output, dev_name) do
      {:ok, output} ->
        output
      {:error, reason} ->
        reason
    end
  end

  def play_note(%Note{} = note) do
    PortMidi.write(note.midi_out, {channel_to_note_on(note.channel), note.note, note.velocity})
    Task.start(fn ->
      :timer.sleep(note.duration)
      stop_note(note)
    end)
  end

  def stop_note(%Note{} = note) do
    PortMidi.write(note.midi_out, {channel_to_note_off(note.channel), note.note, note.velocity})
  end

  def channel_to_note_off(chan) do
    chan + 127
  end

  def channel_to_note_on(chan) do
    chan + 143
  end
end
