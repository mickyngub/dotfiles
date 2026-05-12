#!/bin/sh
# Toggle terminal background tint (OSC 11) based on tmux zoom state.
# Sent through tmux DCS passthrough so the escape reaches the terminal emulator.

tty=$(tmux display-message -p '#{pane_tty}')
zoomed=$(tmux display-message -p '#{window_zoomed_flag}')

if [ "$zoomed" = "1" ]; then
  printf '\033Ptmux;\033\033]11;rgb:2a/2a/00\007\033\\' > "$tty"
else
  printf '\033Ptmux;\033\033]111\007\033\\' > "$tty"
fi
