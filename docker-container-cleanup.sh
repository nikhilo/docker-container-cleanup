#!/bin/bash

# Environment variables needed:
# THRESHOLD integer 0-99
# SLEEP integer > 0

logerr() {
  echo -e "`date` $1" >&2
}

log() {
  echo -e `date` $1
}

re='^[0-9]+$'

if [[ $THRESHOLD =~ $re && $THRESHOLD -lt 100 && $SLEEP =~ $re && $SLEEP -gt 0 ]] ; then
  while true; do
    DISK_USED=$(df -kP /etc/hostname  | awk '/[0-9]%/{ gsub("%","",$5); print $5 }')

    if [ $DISK_USED -gt $THRESHOLD ]; then
      log "Disk usage threshold reached. Cleaning up exited containers."
      docker ps -q -f status=exited | xargs --no-run-if-empty docker rm -v
      log "Cleanup complete."
    else
      log "Disk usage ($DISK_USED%) below threshold ($THRESHOLD%). No action needed."
    fi

    sleep $SLEEP
  done
else
  logerr "Usage :"
  logerr "Env variable THRESHOLD must be set to an integer between 0-99"
  logerr "Env variable SLEEP must be set to an integer > 0"
  exit 1
fi
