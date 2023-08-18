#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/chadwm/scripts/bar_themes/nordic

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$orange_bright^ 󰍛"
	printf "^c$white^ ^b$grey^  $cpu_val"
}

pkg_updates() {
	#updates=$({ timeout 20 doas xbps-install -un 2>/dev/null || true; } | wc -l) # void
	updates=$({ timeout 20 checkupdates 2>/dev/null || true; } | wc -l) # arch
	# updates=$({ timeout 20 aptitude search '~U' 2>/dev/null || true; } | wc -l)  # apt (ubuntu, debian etc)
	if [ -z "$updates" ]; then
		printf "  ^c$green_base^    Fully Updated"
	else
		printf "  ^c$green_base^    $updates"" updates"
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
	printf "^c$grey^ ^b$cyan_base^ 󱐖"
	printf "^c$white^ ^b$grey^  $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$blue^Connected" ;;
	down) printf "^c$black^ ^b$blue^ 󰤭 ^d^%s" " ^c$blue^Disconnected" ;;
	esac
}

dateinfo() {
	printf "^c$black^ ^b$magenta_base^ 󰃵"
	printf "^c$white^ ^b$grey^ $(date '+%d/%m/%y')"
}

timeinfo() {
	printf "^c$black^ ^b$green_base^ 󱑆 "
	printf "^c$black^^b$green_bright^ $(date '+%R')  "
}

weather() {
	weather=$(curl wttr.in/?format="%t\n")
	moon=$(curl -s wttr.in/?format=%m)
	printf "^c$black^ ^b$white^ $moon"
	printf "^c$white^ ^b$grey^  $weather"
}

while true; do

	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
	interval=$((interval + 1))

	# Add  $(battery),  $(brightness) below to see battery usage and brightness on the bar
  sleep 1 && xsetroot -name "$updates $(mem) $(cpu) $(dateinfo) $(weather) $(timeinfo)" # wlan not working for ethernet
done
