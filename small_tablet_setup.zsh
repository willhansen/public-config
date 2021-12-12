#!/bin/zsh


local vertical=false
local large=false

while getopts v:l: flag
do
  case "${flag}" in 
    v) vertical=true;;
    l) large=true;;
  esac
done


#echo $vertical



STYLUS=$(xsetwacom --list devices|rg STYLUS|rg -o "id: [0-9]+"|rg -o "[0-9]+")
PAD=$(xsetwacom --list devices|rg PAD|rg -o "id: [0-9]+"|rg -o "[0-9]+")
if $large
then 
  TOUCH=$(xsetwacom --list devices|rg TOUCH|rg -o "id: [0-9]+"|rg -o "[0-9]+")
  xsetwacom --set "$TOUCH" touch off
fi
# approximately a rectangle the center of the main monitor, with dimensions of 1/8 of $(xsetwacom --get $DEVICE area)
# TODO: get size of rectangle programatically, also draw on screen?
AREA=$(xsetwacom --get "$STYLUS" area)
TABLET_WIDTH=$(echo $AREA | cut -d ' ' -f 3)
TABLET_HEIGHT=$(echo $AREA | cut -d ' ' -f 4)
SUBSCREEN_WIDTH=$(($TABLET_WIDTH/8))
SUBSCREEN_HEIGHT=$(($TABLET_HEIGHT/8))


xsetwacom --set "$STYLUS" Rotate none

if $vertical
then
  xsetwacom --set "$STYLUS" MapToOutput "$SUBSCREEN_HEIGHT"x"$SUBSCREEN_WIDTH"+2500+1150
  xsetwacom --set "$STYLUS" Rotate ccw
else
  if $large
  then
    xsetwacom --set "$STYLUS" MapToOutput HEAD-0
  else
    xsetwacom --set "$STYLUS" MapToOutput HEAD-0
    #xsetwacom --set "$STYLUS" MapToOutput "$SUBSCREEN_WIDTH"x"$SUBSCREEN_HEIGHT"+2300+1240
  fi
fi

# top to bottom, with buttons on left
xsetwacom --set "$PAD" button 1 "key +ctrl z"
xsetwacom --set "$PAD" button 2 "key e"
xsetwacom --set "$PAD" button 3 "key b"

# set pen touch to left mouse button (should be default)
#xsetwacom --set "$STYLUS" button 1 1
