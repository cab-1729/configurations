#!/bin/bash
audio_inf=$(pacmd list-sinks)
echo -n \|\ 
case $(nmcli | awk -F ':' '{print $2;exit 0}') in
		" connected to SANTU")echo -n 📶;;
		" connected to  A11k")echo -n 📱;;
		" disconnected")echo -n ❎;;
		" connected to Wired connection 2")echo -n 🔌;;
		" unavailable")echo -n 🚫;;
		*)echo -n ❓;;
esac
echo -n " | "
case $(sed '65q;d' <<< $audio_inf) in
	"	active port: <analog-output-headphones>")echo -n 🎧;;
	"	active port: <analog-output-lineout>")echo -n 📢;;
esac
echo -n \ $(sed '9q;d' <<< $audio_inf | cut -d '/' -f 2 | cut -b 2-4)\ \|\ 
