FROM cm2network/steamcmd:root AS build_stage

LABEL org.opencontainers.image.source="https://github.com/karnzx/nmrih-docker"
LABEL org.opencontainers.image.description="no more room in hell dedicated server in docker"

# info: https://developer.valvesoftware.com/wiki/Dedicated_Servers_List
ENV STEAMAPPID 317670
ENV STEAMAPP nmrih
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}"
ENV UPDATE_SCRIPT "${STEAMAPPDIR}_update.txt"

# white space not work here (SV=server)
ENV SV_HOSTNAME "NMRIH-SERVER"
ENV SV_PASSWORD ""
ENV RCON_PASSWORD "nmrihPassword"

COPY ./entrypoint.sh ${HOMEDIR}/entrypoint.sh

RUN set -x \
	&& dpkg --add-architecture i386 \ 
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
	 	libncurses5:i386=6.2+20201114-2+deb11u1 \
	 	libtinfo5:i386=6.2+20201114-2+deb11u1 \
	&& mkdir -p $STEAMAPPDIR \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'login anonymous'; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${UPDATE_SCRIPT}" \
	&& chmod +x "${HOMEDIR}/entrypoint.sh" \
	&& apt-get -y autoremove \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entrypoint.sh" "${STEAMAPPDIR}" "${UPDATE_SCRIPT}"

FROM build_stage

# switch from root to steam
USER $USER
WORKDIR $HOMEDIR

# info: https://developer.valvesoftware.com/wiki/Source_Dedicated_Server#Connectivity
# Required port :server
EXPOSE 27015/udp

# Optinal ports
# rcon
EXPOSE 27015
# HLTV
EXPOSE 27020/udp

ENTRYPOINT ["./entrypoint.sh"]
