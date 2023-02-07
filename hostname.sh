#!/bin/bash

INFOFILE="/etc/machine-info"

while [[ $# -gt 0 ]]; do
    case $1 in
        -s)
            BOOL=true
            shift
            ;;
        -n)
            DESCRIPTION="$2"
            shift
            shift
            ;;
    esac
done

if [[ "$BOOL" == true ]]; then #write
    NAME="PRETTY_HOSTNAME"
    if [[ ! -f "$INFOFILE" || ! $(grep --color=never "$NAME=" "$INFOFILE") ]]; then
        echo "$NAME=\"\"" | tee -a "$INFOFILE" > /dev/null
    fi
    DESCRIPTION=\"$DESCRIPTION\"
    HOSTNAME=$(awk -F= "/$NAME/ {print \$2}" "$INFOFILE")
    if [[ "$HOSTNAME" != "$DESCRIPTION" ]]; then #if new hostname differs from previous
        sed -i "s/$NAME=.*/$NAME=$DESCRIPTION/g" "$INFOFILE"
        echo "$INFOFILE: $NAME=$HOSTNAME -> $NAME=$DESCRIPTION"
    else
        echo "$NAME=$DESCRIPTION"
    fi
else #print
    if [[ -f "$INFOFILE" ]]; then
        awk -F= '/HOSTNAME/ {print $2}' "$INFOFILE" #formatted print
    else
        file "$INFOFILE"
        echo -e "\nCreate infofile with -s -n"
    fi
fi