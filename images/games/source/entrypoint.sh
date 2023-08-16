#!/bin/bash
# this file is based on the default pterodactyl yolk

# prevent steamcmd deadlock
sleep 1

# default timezone is UTC
TZ=${TZ:-UTC}
export TZ

# set internal docker ip environment variable
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')

# make sure we are in the container's working directory
cd /home/container || exit 1

# parse all pterodactyl env variables to bash ones
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# if someone removed the default steam user
if [ "${STEAM_USER}" == "" ]; then
	echo -e "no steam user was set\n"
	echo -e "using an anonymous user\n"
	STEAM_USER=anonymous
	STEAM_PASS=""
	STEAM_AUTH=""
else
	echo -e "user is ${STEAM_USER}"
fi

# if auto_update isn't set or only 1 update

if [ -z ${AUTO_UPDATE} ] || [ "${AUTO_UPDATE}" == "1" ]; then
	# update the server
	if [ ! -z ${SRCDS_APPID} ]; then
		./steamcmd/steamcmd.sh +force_install_dir /home/container +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +app_update ${SRCDS_APPID} $( [[ -z ${SRCDS_BETAID} ]] || printf %s "-beta ${SRCDS_BETAID}" ) $( [[ -z ${SRCDS_BETAPASS} ]] || printf %s "-betapassword ${SRCDS_BETAPASS}" ) $( [[ -z ${HLDS_GAME} ]] || printf %s "+app_set_config 90 mod ${HLDS_GAME}" ) $( [[ -z ${VALIDATE} ]] || printf %s "validate" ) +quit
	else
	 	echo -e "no appid was set. starting..."
	fi
else
	echo -e "not updating the server since the user had disabled it. starting..."
fi

# show the command we're running, then execute it
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"

exec env ${PARSED}
