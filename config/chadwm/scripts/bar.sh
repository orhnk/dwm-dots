#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/chadwm/scripts/bar_themes/gruvbox

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$magenta^ 󰍛"
	printf "^c$white^ ^b$grey^  $cpu_val"
}

pkg_updates() {
	#updates=$({ timeout 20 doas xbps-install -un 2>/dev/null || true; } | wc -l) # void
	updates=$({ timeout 20 checkupdates 2>/dev/null || true; } | wc -l) # arch
	# updates=$({ timeout 20 aptitude search '~U' 2>/dev/null || true; } | wc -l)  # apt (ubuntu, debian etc)
	if [ -z "$updates" ]; then
		printf "  ^c$green_dark^    Fully Updated"
	else
		printf "  ^c$green_dark^    $updates"" updates"
	fi
}

# battery() {
#   get_capacity="$(cat /sys/class/power_supply/BAT1/capacity)" # for laptops (computers which has batteries) uncomment these lines
#   printf "^c$blue^   $get_capacity"
# }

# brightness() {
#   printf "^c$red^   "
#   printf "^c$red^%.0f\n" $(cat /sys/class/backlight/*/brightness)
# }

mem() {
	# 󱘗 -> saved for future use
	printf "^c$grey^ ^b$blue^ 󱐖"
	printf "^c$white^ ^b$grey^  $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$blue^Connected" ;;
	down) printf "^c$black^ ^b$blue^ 󰤭 ^d^%s" " ^c$blue^Disconnected" ;;
	esac
}

dateinfo() {
	printf "^c$black^ ^b$aqua^ 󰃵"
	printf "^c$white^ ^b$grey^ $(date '+%d/%m/%y')"
}

timeinfo() {
	printf "^c$black^ ^b$green_dark^ 󱑆 "
	printf "^c$black^^b$green^ $(date '+%R')"
}

weather() {
	weather=$(curl wttr.in/?format="%t\n")
	moon=$(curl -s wttr.in/?format=%m)
	printf "^c$black^ ^b$white^ $moon"
	printf "^c$white^ ^b$grey^  $weather"
}

vim() {
	printf "^c$green^"
}

firefox() {
	printf "^c$orange^"
}

emacs() {
	printf "^c$blue^"
}

recorder() {
	printf "^c$red^ ^b$black^ ⏺️"
}

while true; do
	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
	interval=$((interval + 1))

	# Add  $(battery),  $(brightness) below to see battery usage and brightness on the bar
	sleep 1 && xsetroot -name "$updates    $(firefox) $(vim) $(emacs)    $(weather) $(cpu) $(mem) $(dateinfo) $(timeinfo) $(recorder)" # wlan not working for ethernet
done
