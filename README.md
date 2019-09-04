# Info

[Darkstat](https://unix4lyfe.org/darkstat/) - Captures network traffic, calculates statistics about usage, and serves reports over HTTP.

Dockerized version built from source. Initially based on [macexx/darkstat](https://github.com/macexx/darkstat).

# Usage

### Env vars

- `INTERFACE` - interface to listen on
- `UI_HOST` - address to bind UI to, defaults to `127.0.0.1`
- `UI_PORT` - port to bind UI to, defaults to `9666`

Example run with:

- UI binded to `10.0.0.1:9095`
- listening for events on `eno1` interface

```
docker run \
  --name=darkstat \
  --detach \
  --restart unless-stopped \
  --network host \
  -v /var/lib/darkstat:/darkstat \
  -v /etc/localtime:/etc/localtime:ro \
  -e INTERFACE=eno1 \
  -e UI_PORT=9095 \
  -e UI_HOST=10.0.0.1 \
  agrrh/darkstat
```

Also feel free to run with parameters suiting your needs:

```
docker run --rm -ti agrrh/darkstat darkstat --help
docker run --rm -ti agrrh/darkstat darkstat <custom params>
```

e.g.

```
docker run --rm -ti agrrh/darkstat darkstat -i eno5 --local-only
```
