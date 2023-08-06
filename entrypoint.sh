#!/bin/bash

# useful commands
# https://steamcommunity.com/sharedfiles/filedetails/?id=423306040
# server options
# https://steamcommunity.com/app/224260/discussions/0/2595630410178365636/

# install/update
if [ ! -n "$(ls -A ${STEAMAPPDIR} 2>/dev/null)" ]; then
	${STEAMCMDDIR}/steamcmd.sh +runscript ${UPDATE_SCRIPT}
fi

echo "Server Hostname: $SV_HOSTNAME"

cd "${STEAMAPPDIR}"
# https://pingperfect.com/index.php/knowledgebase/529/No-More-Room-In-Hell-NMRIH--Server-Configuration.html
"${STEAMAPPDIR}/srcds_run" -game $STEAMAPP -console \
	+maxplayers 8 \
	+map "nmo_cabin" \
	+hostname $SV_HOSTNAME \
	+sv_password $SV_PASSWORD \
	+rcon_password $RCON_PASSWORD \
	+exec server.cfg

