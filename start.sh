#!/bin/bash

docker run -d -i -t --name nmrih-server \
	-p 27015:27015/udp \
	--restart=unless-stopped \
	nmrih
