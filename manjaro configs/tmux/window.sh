#!/bin/bash
case "$1" in
	"youtube")
		tmux neww -n youtube -c "/mnt/d/Resources/youtube"
		#main split - api results
		sleep 0.05
		tmux send-keys "curl -s \"https://youtube.googleapis.com/youtube/v3/playlistItems?key=\$(<key)&part=snippet&maxResults=5&playlistId=\$(<)\" | less"
		tmux send-keys Left Left Left Left Left Left Left Left Left
		#side split - video download
		tmux split-window -h -c /mnt/c/Users/USER/Downloads/ -l 48
		sleep 0.05
		tmux send-keys "yt-dlp --write-thumbnail --embed-chapters \"https://www.youtube.com/watch?v=\""
		tmux send-keys Left
		tmux select-pane -L
		: '
		tmux split-window -v -c /mnt/c/Users/USER/Downloads/ -l 5
		#bottom split - thumbnail download
		sleep 0.05
		tmux send-keys "curl -s \"https://i.ytimg.com/vi//sddefault.jpg\" > .jpg"
		tmux send-keys Left Left Left Left Left Left Left Left Left Left Left Left Left Left Left Left Left Left Left Left Left Left
		tmux select-pane -U
		'
		;;
	"docs")
		tmux neww -n docs
		sleep 0.05
		tmux send-keys "man "
		;;
	"todos")
		tmux neww -n todos
		sleep 0.05
		tmux send-keys "calcurse"
		tmux send-keys Enter
		;;
	"asmr")
		tmux neww -n asmr
		sleep 0.05
		tmux send-keys "ranger /mnt/d/Satan/Sample\ Videos/ASMR /mnt/c/Users/USER/Downloads"
		tmux send-keys Enter
		;;
	*)
		tmux neww -n "$1"
		;;
esac
