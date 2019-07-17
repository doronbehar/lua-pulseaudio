# PulseAudio Lua C bindings

This project is a fork of [@liaonau](https://github.com/liaonau)'s [original project](https://github.com/liaonau/lua-pulseaudio). The need to fork it came up after [some open pull requests of mine](https://github.com/liaonau/lua-pulseaudio/pulls/doronbehar) got ignored. Besides Lua 5.2 and 5.3 support, I forked because I wanted to modernise this project by adding the following as well:

- README
- LuaRocks spec

## Install

```
luarocks install pulseaudio
```

## Usage

For this demonstration, I assume you have penlight installed, just for the sake of [`pl.pretty`](https://stevedonovan.github.io/Penlight/api/libraries/pl.pretty.html).

```lua
> inspect = require('pl.import_into')().pretty.write
> pulseaudio = require("pulseaudio")
> sinks = pulseaudio.get_sinks()
-- sinks now is a table of all sinks
> inspect(sinks)
-- Sinks are indexed in the table by both their number and their name.
-- Note that sinks[1] is the first object appearing here. That is because 
-- arrays' indexes in Lua usually start in 1
{
  {
    index = 1.0,
    volume = 25.0,
    name = "alsa_output.pci-0000_00_1b.0.analog-stereo",
    default = false,
    mute = false
  },
  [0] = {
    index = 0.0,
    volume = 24.0,
    name = "alsa_output.pci-0000_00_03.0.hdmi-stereo",
    default = true,
    mute = false
  },
  ["alsa_output.pci-0000_00_03.0.hdmi-stereo"] = {
    index = 0.0,
    volume = 24.0,
    name = "alsa_output.pci-0000_00_03.0.hdmi-stereo",
    default = true,
    mute = false
  },
  ["alsa_output.pci-0000_00_1b.0.analog-stereo"] = {
    index = 1.0,
    volume = 25.0,
    name = "alsa_output.pci-0000_00_1b.0.analog-stereo",
    default = false,
    mute = false
  }
}
> sink_inputs = pulseaudio.get_sink_inputs()
> inspect(sink_inputs)
{
  [0] = {
    index = 0.0,
    pid = 855.0,
    binary = "mpd",
    volume = 100.0,
    name = "Music Player Daemon",
    mute = false,
    sink = 0.0
  }
}
-- Moves the sink input called "mpd" (addressed by index 0) to sink:
-- First argument is the sink input's index / name and the second is the sink's index
> sink_input_index = 0
> sink_index = 1
> pulseaudio.move_sink_input(sink_input_index, sink_index)
-- Sets's a sink's volume:
-- First argument is the sink's index / name and the second is the new volume to set, from 0 to 100
> pulseaudio.set_sink_volume(1, 15)
-- The same goes for setting a sink's input's volume:
> pulseaudio.set_sink_volume(0, 95)
-- Lastly, setting the default sink is easy, using the index / name of the requested sink:
> pulseaudio.set_default_sink(1)
```

I use this Luarock as a dependency for another Luarock I maintain: [`lua-pulseaudio_cli`](https://gitlab.com/doronbehar/lua-pulseaudio_cli). In a way, this is a 'real world' example of this library used. [`lua-pulseaudio_cli`](https://gitlab.com/doronbehar/lua-pulseaudio_cli) is a higher level API for pulseaudio in comparison to `lua-pulseaudio`. I use [`lua-pulseaudio_cli`](https://gitlab.com/doronbehar/lua-pulseaudio_cli) in [my Awesome WM configuration](https://github.com/doronbehar/.config_awesome).
