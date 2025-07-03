#!/usr/bin/env bash

#gaps_in=$(hyprctl -j getoption general:gaps_in | jq '.int')
#gaps_out=$(hyprctl -j getoption general:gaps_out | jq '.int')

gaps_in=$(hyprctl -j getoption general:gaps_in | jq '.custom' | awk '{print $1}' | cut -c 2-)
gaps_out=$(hyprctl -j getoption general:gaps_out | jq '.custom' | awk '{print $1}' | cut -c 2-)

function reset () {
  hyprctl keyword "general:gaps_in" 10
  hyprctl keyword "general:gaps_out" 10
}

function inc_gaps_in () {
  hyprctl keyword general:gaps_in $((gaps_in+5))
}

function dec_gaps_in () {
  hyprctl keyword general:gaps_in $((gaps_in-5))
}

function inc_gaps_out () {
  hyprctl keyword general:gaps_out $((gaps_out+5))
}

function dec_gaps_out () {
  hyprctl keyword general:gaps_out $((gaps_out-5))
}

while [[ $# -gt 0 ]]; do
  case $1 in
    --inc_gaps_in)   inc_gaps_in;   shift ;;
    --dec_gaps_in)   dec_gaps_in;   shift ;;
    --inc_gaps_out)  inc_gaps_out;  shift ;;
    --dec_gaps_out)  dec_gaps_out;  shift ;;
    --reset)         reset;         shift;;:
    *)               printf "Error: Unknown option %s" "$1"; exit 1 ;;
  esac
done
