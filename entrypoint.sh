#!/bin/bash

# useful commands
# https://steamcommunity.com/sharedfiles/filedetails/?id=423306040
# server options
# https://steamcommunity.com/app/224260/discussions/0/2595630410178365636/

# install/update
if [ ! -n "$(ls -A ${STEAMAPPDIR} 2>/dev/null)" ]; then
	${STEAMCMDDIR}/steamcmd.sh +runscript ${UPDATE_SCRIPT}
	cat <<EOF > "${STEAMAPPDIR}/${STEAMAPP}/cfg/server.cfg"
// hostname "[WORLD]NMRIH-SERVER"
// map "nmo_broadway"
// maxplayers 8
// sv_password "1234"
// rcon_password "myRconPassword"
// sv_realism 0
// sv_hardcore_survival 0
// sv_difficulty "classic"
// sv_region -1
// mp_friendlyfire 1
// sv_idle_autokick_enabled 0
// sv_cheats 0
EOF
fi

echo "Server Hostname: $SV_HOSTNAME"

cd "${STEAMAPPDIR}"
"${STEAMAPPDIR}/srcds_run" -game $STEAMAPP -console \
	+maxplayers 8 \
	+map "nmo_cabin" \
	+hostname $SV_HOSTNAME \
	+sv_password $SV_PASSWORD \
	+rcon_password $RCON_PASSWORD \
	+exec server.cfg

