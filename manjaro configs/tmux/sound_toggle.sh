#!/bin/bash
if [ "$(pacmd list-sinks | sed '65q;d')" == "	active port: <analog-output-headphones>" ];then
	pacmd set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-lineout
else
	pacmd set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-headphones
fi
