# nmrih-docker

no more room in hell dedicated server in docker 

used to Create dedicated server to play with friends

## Usage

### Manual build

clone and build 

```shell
git clone https://github.com/karnzx/nmrih-docker.git
docker build -t nmrih .
```

run with minimum port `20175/udp`

```shell
docker run -d -i -t --name nmrih-server \
	-p 27015:27015/udp \
	--restart=unless-stopped \
	nmrih
```

Restart by run 

```shell
docker restart nmrih-server
```

Delete by run (force remove nmrih-server container)

```shell
docker rm -f nmrih-server
```

If use persistence volume be sure that directory owner is user id 1000

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
