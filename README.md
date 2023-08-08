# nmrih-docker

[no more room in hell](https://store.steampowered.com/app/224260/No_More_Room_in_Hell/) dedicated server in docker 

I use this to create a private, dedicated server for playing with friends, allowing us to relive the cherished memories of our childhood.

## Usage

Start server with default server config or edit [server config](#config) instead.

```shell
docker run -d -i -t --name nmrih-server \
        -p 27015:27015/udp \
	-e SV_HOSTNAME="server-name" \
	-e SV_PASSWORD="1234" \
	ghcr.io/karnzx/nmrih-docker:latest
```

Should be run with minimum port `20175/udp` or you can expose `27015` and `27020/udp` too if you want.

```shell
docker run -d -i -t --name nmrih-server \
	-p 27015:27015/udp \
        -p 27015:27015 \
        -p 27020:27020/udp \
	--restart=unless-stopped \
	ghcr.io/karnzx/nmrih-docker:latest
```

**If use persistence volume be sure that directory user owner id is 1000**, severfiles stored at `/home/steam/nmrih/`

```shell
docker run -d -i -t --name nmrih-server \
        -p 27015:27015/udp \
        -v ./nmrih:/home/steam/nmrih/ \
        --restart=unless-stopped \
        ghcr.io/karnzx/nmrih-docker:latest
```

Restart by run 

```shell
docker restart nmrih-server
```

Delete by run (force remove nmrih-server container)

```shell
docker rm -f nmrih-server
```

## Console

Using server console so you can run commands directly by run `docker attach`

Note: Detach by press `Ctrl+P+Q` 

```shell
docker attach nmrih-server
```

## Config

edit `server.cfg` in `nmrih/nmrih/cfg/server.cfg`

```shell
docker exec -i -t nmrih-server nano nmrih/nmrih/cfg/server.cfg
```

## Credit & Ref

- https://github.com/CM2Walki/TF2
