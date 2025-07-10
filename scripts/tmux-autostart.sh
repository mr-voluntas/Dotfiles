#!/bin/bash

SESSION="my_project"
PROJECT_DIR="$HOME/projects/my_project"

# Kill session if it already exists
tmux kill-session -t "$SESSION" 2>/dev/null

# Create session and first window
tmux new-session -d -s "$SESSION" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:0" "nvim" C-m

# Create 'short' window
tmux new-window -t "$SESSION:" -c "$PROJECT_DIR"

# Create 'long' window
tmux new-window -t "$SESSION:" -c "$PROJECT_DIR"

# Disable the status bar
tmux set-option -t "$SESSION" status off

# Select the first window (index 0)
tmux select-window -t "$SESSION:0"

# Attach to session
tmux attach-session -t "$SESSION"

