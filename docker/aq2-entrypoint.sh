#!/bin/bash
set -e

while read var; do
  [ -z "${!var}" ] && { echo "$var is empty or not set. Exiting."; exit 1; }
done << EOF
TEAM_1_NAME
TEAM_2_NAME
TEAM_1_MODEL
TEAM_1_SKIN
TEAM_2_MODEL
TEAM_2_SKIN
AQ_HOSTNAME
AQ_PORT
AQ_CONFIG
AQ_MAXCLIENTS
AQ_RCON_PASSWORD
EOF

if [[ ${AQ_RCON_PASSWORD} = "pleaseupdateme" ]]; then
  echo "You didn't update the AQ_RCON_PASSWORD value!"
  echo "This should be secret and not shared, but simple enough to type."
  echo "It's also adjustable if you want to change it at any time,"
  echo "just change the value in the .env file and restart the server."
  exit 1
fi

## Replace with actual values
sed -i "s/TEAM_1_NAME/${TEAM_1_NAME}/g" /opt/aq2/action/action.ini
sed -i "s/TEAM_2_NAME/${TEAM_2_NAME}/g" /opt/aq2/action/action.ini
sed -i "s/TEAM_1_MODEL/${TEAM_1_MODEL}/g" /opt/aq2/action/action.ini
sed -i "s/TEAM_1_SKIN/${TEAM_1_SKIN}/g" /opt/aq2/action/action.ini
sed -i "s/TEAM_2_MODEL/${TEAM_2_MODEL}/g" /opt/aq2/action/action.ini
sed -i "s/TEAM_2_SKIN/${TEAM_2_SKIN}/g" /opt/aq2/action/action.ini

## Run q2proded

/opt/aq2/q2proded +set game action +set hostname "${AQ_HOSTNAME}" +set net_port "${AQ_PORT}" +exec ${AQ_CONFIG}.cfg