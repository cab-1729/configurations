#!/bin/bash
#Takes two path arguments, converts second path to windows path and runs program in first path with windows path as argument
cmd.exe /c start "$1" "${2:5:1}:\\${2:7}" | sed 's/\//\\/g' & disown
