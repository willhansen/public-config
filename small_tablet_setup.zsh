STYLUS=$(xsetwacom --list devices|rg STYLUS|rg -o "id: [0-9]+"|rg -o "[0-9]+")
PAD=$(xsetwacom --list devices|rg PAD|rg -o "id: [0-9]+"|rg -o "[0-9]+")
# approximately a rectangle the center of the main monitor, with dimensions of 1/8 of $(xsetwacom --get $DEVICE area)
# TODO: get size of rectangle programatically, also draw on screen?
xsetwacom --set "$STYLUS" MapToOutput 1042x585+2300+1300
# top to bottom, with buttons on left
xsetwacom --set "$PAD" button 1 "key +ctrl z"
xsetwacom --set "$PAD" button 2 "key e"
xsetwacom --set "$PAD" button 3 "key b"

# set pen touch to left mouse button (should be default)
#xsetwacom --set "$STYLUS" button 1 1
