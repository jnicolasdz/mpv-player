#!/bin/bash

text=$1
if pidof yad > /dev/null; then
        pkill yad
fi

yad --info \
    --title="PopUp" \
    --text="$text" \
    --on-top \
    --no-buttons \
    --skip-taskbar \
    --timeout=3 \
    --undecorated \
    --geometry=10x10
