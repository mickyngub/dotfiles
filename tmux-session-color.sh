#!/usr/bin/env bash
# Apply a per-session tmux color scheme derived from the session name.
# Colors the status bar, active pane border, and terminal title.

session="${1:-$(tmux display-message -p '#S')}"
[ -z "$session" ] && exit 0

# Paired palette: dark bg for status, bright accent for pane border.
bg_colors=(17  22  52  53  130 23  88  58  90  94  18  28  54  124 136 19  29  55)
fg_colors=(33  40  160 135 208 51  197 148 201 172 27  46  129 196 220 63  42  141)

hash=$(printf '%s' "$session" | cksum | awk '{print $1}')
idx=$(( hash % ${#bg_colors[@]} ))
bg="${bg_colors[$idx]}"
fg="${fg_colors[$idx]}"

tmux set-option -t "$session" status-style "bg=colour${bg},fg=white"
tmux set-option -t "$session" status-left  "#[bg=colour${bg},fg=white,bold] #S #[default] "
tmux set-option -t "$session" pane-border-style        "fg=colour238"
tmux set-option -t "$session" pane-active-border-style "fg=colour${fg},bold"
tmux set-option -t "$session" set-titles on
tmux set-option -t "$session" set-titles-string "tmux · #S · #W"
