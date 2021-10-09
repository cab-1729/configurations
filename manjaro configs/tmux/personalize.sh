#!/bin/bash
audio_inf=$(pacmd list-sinks)
device=$(sed '65q;d' <<< $audio_inf)
if [ "$device" == "	active port: <analog-output-headphones>" ]; then
	device=Headphones
elif [ "$device" == "	active port: <analog-output-lineout>" ]; then
	device=Speakers
fi
network_inf=$(nmcli | sed '1q;d')
if [ "$network_inf" == "wlp0s20f0u10u3: connected to SANTU" ]; then
	connection="Wifi"
elif [ "$network_inf" == "wlp0s20f0u10u3: connected to  A11k" ]; then
	connection="Mobile"
elif [ "$network_inf" == "wlp0s20f0u10u3: disconnected" ]; then
	connection="Not connected"
else
	connection="Unknown"
fi
echo -n \|\ $connection\ \|\ $device\ $(sed '9q;d' <<< $audio_inf | cut -d '/' -f 2 | cut -b 2-4)\ \|\ 
