#!/bin/zsh
#
# dzen/xmonad statusline, (c) 2007 by ryz
#

# Configuration
DATE_FORMAT='%A, %d.%m.%Y %H:%M:%S'

# Main loop interval in seconds
INTERVAL=1

# function calling intervals in seconds
DATEIVAL=1
GTIMEIVAL=60

# Functions
fdate() {
    date +${DATE_FORMAT}
}

fgtime() {
    local i

    for i in $TIME_ZONES
        { print -n "${i:t}:" $(TZ=$i date +'%H:%M')' ' }
}

# Main

# initialize data
DATECOUNTER=0;GTIMECOUNTER=0;
PDATE=$(fdate)
PGTIME=$(fgtime)

while true; do
   if [ $DATECOUNTER -ge $DATEIVAL ]; then
     PDATE=$(fdate)
     DATECOUNTER=0
   fi

   if [ $GTIMECOUNTER -ge $GTIMEIVAL ]; then
     PGTIME=$(fgtime)
     GTIMECOUNTER=0
   fi

   # Arrange and print the status line
   print "$PGTIME ^fg(white)${PDATE}^fg()"

   DATECOUNTER=$((DATECOUNTER+1))
   GTIMECOUNTER=$((GTIMECOUNTER+1))

   sleep $INTERVAL
done
