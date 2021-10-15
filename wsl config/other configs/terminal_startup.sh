#!/bin/bash
tmux ls && tmux a || (mkdir /run/tmux;tmux)
