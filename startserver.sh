#!/bin/bash

docker run -d -i -t --name nmrih-server \
	-p 27015:27015/udp \
	-v ./nmrih:/home/steam/nmrih/ \
	--restart=unless-stopped \
	ghcr.io/karnzx/nmrih-server
