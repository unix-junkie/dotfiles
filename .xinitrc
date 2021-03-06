#!/bin/bash
#
# ~/.xinitrc
#
# vim:ft=sh:
#

[[ -f ~/.Xresources ]] && xrdb -merge -I${HOME} ~/.Xresources

declare -a monitors
for monitor in $(xrandr | grep -F ' connected ' | awk '{print $1}')
do
	monitors+=("${monitor}")
done

case "$(hostname -s)" in
	'proxima')
		if [[ ${#monitors[*]} -eq 1 && "${monitors[0]}" = 'eDP1' ]]
		then
			dpi=142
		elif [[ ${#monitors[*]} -eq 2 ]]
		then
			xrandr --setprovideroffloadsink 1 0

			for monitor in ${monitors[*]}
			do
				case "${monitor}" in
					'eDP1')
						xrandr --output "${monitor}" --off
						;;
					'HDMI1')
						# Intel videocard, 4k HDMI display.
						dpi=162
						xrandr --output "${monitor}" --primary
						xrandr --output "${monitor}" --set "Broadcast RGB" "Full"
						;;
					'DP1')
						# Intel videocard, 2k DP display.
						dpi=91
						xrandr --output "${monitor}" --primary
						xrandr --output "${monitor}" --set "Broadcast RGB" "Full"
						;;
					*)
						;;
				esac
			done
		fi
		;;
	'unit-725')
		# We've configured the mouse manually, and the auto-detected duplicate
		# causes mouse wheel to stop working in Qt5 applications.
		xinput --disable 'Logitech USB Laser Mouse'

		if [[ ${#monitors[*]} -eq 2 ]]
		then
			for monitor in ${monitors[*]}
			do
				case "${monitor}" in
					'HDMI1')
						xrandr --output "${monitor}" --primary
						;;
					*)
						;;
				esac
			done
		fi
		;;
	*)
		;;
esac

if [[ -n "${dpi}" ]]
then
	xrandr --dpi "${dpi}"
	xrdb -override <<EOF
Xft.dpi: ${dpi}
EOF
fi

if [[ -x "$(which xbindkeys)" ]]
then
	xbindkeys
fi

xscreensaver -no-splash &

exec x-window-manager || exec wmaker || exec mwm || exec twm
