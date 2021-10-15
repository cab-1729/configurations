#!/bin/bash
#bound to key Alt+ Enter and Alt +T
#if terminal not open open terminal else bring it in forward
wmctrl -l | grep Terminal && wmctrl -a Terminal || alacritty
