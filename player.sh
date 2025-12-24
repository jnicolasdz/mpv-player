#!/usr/bin/env bash

declare -A playlist=() 
declare -A array=()

index=0
option=$1
name=$2
link=$3
file=$HOME/.config/UserScripts/music.conf
popup=$HOME/.config/UserScripts/popup.sh

if [[ ! -e $HOME/.config/UserScripts/music.conf ]]; then
	touch $file
fi
declare -A playlist=()
if [[ -s $HOME/.config/UserScripts/music.conf ]]; then
	current=$(head -n 1 $file)
	for element in $(tail -n +2 $file | cut -d "" -f 1,2)
	do
	   IFS="¬" read -ra details <<< "$element"
	   playlist["${details[0]}"]="${details[1]}"
           array["$index"]="${details[0]}"
           index=$((index+1))
 	done
fi

if [[ "$option" == "ls" ]]; then
	echo "Index : Name : Source"
	index=0
	for i in {0..${!array[@]}} 
	do 
	   echo $index : ${array[$index]} : ${playlist[${array[$index]}]}
	   index=$((index+1)) 
       done
       echo "Current: $current"

elif [[ "$option" ==  "add" ]]; then 
	playlist["$name"]="$link"
	array["$index"]="$name"
	echo -e "$name¬${playlist[$name]}" >> $file
	echo "$name added to the playlist"

elif [[ $option == "remove" ]]; then
        unset playlist[$name]
	rm $file && touch $file
        for key in ${!playlist[@]}
        do
           echo -e $key¬${playlist[$key]} >> $file
        done
        echo "$name removed from the playlist"

elif [[ $option == "play" ]]; then
	sed -ir "s|^[0-9]$|${name}|" $file
	if [[ $name -eq 0 ]]; then 
		name=$current
	fi
	echo "current: $name"
	exec $( $popup "Now it's playing ${array[$name]}") &
	mpv --script=$HOME/.config/mpv/scripts/mpris.so --no-terminal --no-video ${playlist[${array[$name]}]}

elif [[ $option == "pause" ]]; then
	exec $( $popup "Music Paused/Play") &
	playerctl -p mpv play-pause

elif [[ $option == "stop" ]]; then
	exec $( $popup "Music has stopped") &
	playerctl -p mpv stop 

elif [[ $option == "next" ]]; then
	playerctl -p mpv stop
	next=$((current + 1))
	if [[ $next -ge ${#array[@]} ]]; then
		next=0
	fi
	sed -ir "s|^[0-9]$|${next}|" $file
	exec $( $popup "Now it's playing ${array[$next]}") &
	mpv --script=$HOME/.config/mpv/scripts/mpris.so --no-terminal --no-video ${playlist[${array[$next]}]}

elif [[ $option == "previous" ]]; then
	playerctl -p mpv stop
        previous=$((current - 1))
        if [[ $previous -lt 0 ]]; then
		previous=$((${#array[@]} - 1 ))
        fi
        sed -ir "s|^[0-9]$|${previous}|" $file
	exec $( $popup "Now it's playing ${array[$previous]}") &
        mpv --script=$HOME/.config/mpv/scripts/mpris.so --no-terminal --no-video ${playlist[${array[$previous]}]}

#TODO: opcion de busqueda usando grep, opcion de reproduccion indefinida o definida, opcion de queue 
fi
