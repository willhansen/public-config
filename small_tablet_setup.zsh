DEVICE=$(xsetwacom --list devices|rg STYLUS|rg -o "id: [0-9]+"|rg -o "[0-9]+")
# approximately a rectangle the center of the main monitor, with dimensions of 1/8 of $(xsetwacom --get $DEVICE area)
xsetwacom --set "$DEVICE" MapToOutput 1042x585+2300+1300
xsetwacom --set "$DEVICE" button 1 "a"
