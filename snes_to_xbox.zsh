

# https://github.com/RetroPie/RetroPie-Setup/wiki/Universal-Controller-Calibration-&-Mapping-Using-xboxdrv

xboxdrv \
  --evdev /dev/input/by-id/usb-0079_USB_Gamepad-event-joystick \
#  --silent \
#  --detach-kernel-driver \
#  --force-feedback \
#	--deadzone-trigger 15% \
#	--deadzone 4000 \
	--mimic-xpad \
	--evdev-absmap ABS_X=x1,ABS_Y=y1 \
	--evdev-keymap BTN_THUMB2=a,BTN_THUMB=b,BTN_TOP=x,BTN_TRIGGER=y,BTN_TOP2=lb,BTN_PINKIE=rb,BTN_BASE3=back,BTN_BASE4=start \
#	&
