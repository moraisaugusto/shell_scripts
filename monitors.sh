#!/usr/bin/env sh

# Please define your monitors
EXTERNAL1="DP-5"
EXTERNAL2="DP-0"
INTERNAL="DP-4"

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
            xrandr --output $EXTERNAL1 --primary --mode 3840x2160 --rate 120 --scale 1x1 --output $EXTERNAL2 --mode 3840x2160 --rate 60 --scale 1x1 --left-of $EXTERNAL1 --output $INTERNAL --off
        elif [[ $MONITORS == "1-external-and-internal" ]];then
            printf "Enabling $MONITORS monitor(s)\n"
            xrandr --output $EXTERNAL1 --primary --mode 3840x2160 --rate 120 --scale 1x1 --output $EXTERNAL2 --off --output $INTERNAL --mode 1920x1080 --right-of $EXTERNAL1 --scale  1.4x1.4
        elif [[ $MONITORS == "1-external" ]];then
            xrandr --output $EXTERNAL1 --primary --mode 3840x2160 --rate 120 --scale 1x1 --output $EXTERNAL2 --off --output $INTERNAL --off
            printf "Enabling $MONITORS monitor(s)\n"
        elif [[ $MONITORS == "1-internal" ]];then
            printf "Enabling $MONITORS monitor(s)\n"
            xrandr --output $EXTERNAL1 --off --output $EXTERNAL2 --off --output $INTERNAL --primary --mode 1920x1080 --scale 1.6x1.6
        fi
        shift
    fi
shift
done
