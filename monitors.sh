#!/usr/bin/env sh

function show_usage(){
    cat << EOF
Usage:
    -o|--only        Provide monitors: [2-externals, 1-external-and-internal, 1-external, 1-internal]
EOF
}

while [ ! -z "$1" ]; do
    if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]];then
        show_usage
    elif [[ $1 == "-o" ]] || [[ "$1" == "--only" ]];then
        MONITORS="$2"
        if [[ $MONITORS == "2-externals" ]];then
            printf "Enabling $MONITORS monitor(s)\n"
            xrandr --output DP-5 --primary --mode 3840x2160 --rate 120 --scale 1x1 --output DP-0 --mode 3840x2160 --rate 60 --scale 1x1 --left-of DP-5 --output DP-4 --off
        elif [[ $MONITORS == "1-external-and-internal" ]];then
            printf "Enabling $MONITORS monitor(s)\n"
            xrandr --output DP-5 --primary --mode 3840x2160 --rate 120 --scale 1x1 --output DP-0 --off --output DP-4 --mode 1920x1080 --right-of DP-5 --scale  1.4x1.4
        elif [[ $MONITORS == "1-external" ]];then
            xrandr --output DP-5 --primary --mode 3840x2160 --rate 120 --scale 1x1 --output DP-0 --off --output DP-4 --off
            printf "Enabling $MONITORS monitor(s)\n"
        elif [[ $MONITORS == "1-internal" ]];then
            printf "Enabling $MONITORS monitor(s)\n"
            xrandr --output DP-5 --off --output DP-4 --primary --mode 1920x1080 --scale 1.6x1.6 --output DP-5 --off
        fi
        shift
    fi
shift
done
