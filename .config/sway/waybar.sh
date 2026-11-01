#!/usr/bin/bash

while true; do
# Tempo e hora
# outras datas
# '%A %-d, %B(%-m) %Y [%H:%M] (%:z %Z) ' -> 'Wednesday 23, October(10) 2024 [22:50] (+02:00 CEST) '
tempo=$(date +'%-d-%-m-%Y [%H:%M]' 2>&1)
# printf -v tempo '%(%-d-%-m-%Y [%H:%M])T'

# Bateria
bateria_carga="$(cat '/sys/class/power_supply/BAT0/capacity' 2>&1)"
cargando=""
[ "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = '1' ] && cargando=" 󱐋"

# Carga media do CPU, media do ultimo minuto
cargamedia=$(cat /proc/loadavg 2>&1 | awk -F ' ' '{print $1}' 2>&1)

# RAM usada
ram=$(free --mebi 2>&1 | sed -n '2{p;q}' 2>&1 | awk '{printf ("%2.2f GiB", ( $3 / 1024) )}' 2>&1)

# Volumen
volumen=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>&1 | awk '{printf ("%2.f", ($2 * 100))}' 2>&1)
muteado=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>&1 | awk '{printf ("%s", ($3))}' 2>&1)
[ -n "$muteado" ] && muteado=" ${muteado}" # uso esto pa engadir un espazo á string solo se non está baleira

# Brillo da pantalla
brillo_actual=$(cat /sys/class/backlight/*/brightness 2>&1)
brillo_maximo=$(cat /sys/class/backlight/*/max_brightness 2>&1)
brillo=$((100 * brillo_actual / brillo_maximo))

if [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'up' ] ; then
    wifiicon="$(awk '/^\s*w/ { print "󰖩", int($3 * 100 / 70) "% " }' /proc/net/wireless)"
elif [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'down' ] ; then
    [ "$(cat /sys/class/net/w*/flags 2>/dev/null)" = '0x1003' ] && wifiicon="󱛆 " || wifiicon="󱛅 "
fi

# by Luke Smith
update() {
    sum=0
    for arg; do
        read -r i < "$arg"
        sum=$(( sum + i ))
    done
    cache=/tmp/${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=0
    printf %d\\n "$sum" > "$cache"
    printf %d\\n $(( sum - old ))
}

bytes_r=$(update /sys/class/net/[ew]*/statistics/rx_bytes | numfmt --to=iec | awk '{printf ("%5sB", ($1))}')
bytes_t=$(update /sys/class/net/[ew]*/statistics/tx_bytes | numfmt --to=iec | awk '{printf ("%5sB", ($1))}')

[ "$(cat /sys/class/net/e*/operstate 2>/dev/null)" = 'up' ] && ethericon="󰈀" || ethericon=""

router="$(iwgetid -r 2>&1)"

echo "  $bytes_r  $bytes_t ($router) $wifiicon $ethericon│   $cargamedia │   $ram │ 󰁿 $bateria_carga%$cargando │ 󰕾 $volumen%$muteado │ 󰃟 $brillo% │ $tempo "

sleep 1

done
