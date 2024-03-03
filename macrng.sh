#!/bin/sh

#   - simple MAC address randomizer -
#   Copyright (C) 2023  sumcodebit  -@github.com
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.

## MAC randomizer script which gets called by udev rule @
## /etc/udev/rules.d/56-macrng_udev.rules
## default installpath is /usr/local/bin/macrng.sh

if [ -z "$1" ]; then

	# comment next line: to silence error outputs
	printf "%s%s" "$(date)" "Error: No Interface found" >> /tmp/macrng.log
    exit 1

else

    printf -v unimac "%02x%s" "$[ $RANDOM %128 * 2 ]" "$(od -A n -t x1 -N 5 /dev/urandom | sed 's/ /:/g')"

    ip link set dev "$1" down
    ip link set dev "$1" address $unimac
    ip link set dev "$1" up

	# uncomment next line: to log output
    #printf "%s%s%s" "$(date)" "$1" "$unimac" >> /tmp/macrng.log
    exit

fi
