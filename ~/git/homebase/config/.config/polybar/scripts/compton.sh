#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep -x compton)" ]; then
            pkill compton
        else
            compton --config ~/.config/compton/solid.conf &
        fi
        ;;
    *)
        if [ "$(pgrep -x compton)" ]; then
            echo "Compton"
        else
            echo "Compton"
        fi
        ;;
esac
