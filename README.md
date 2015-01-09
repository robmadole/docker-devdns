# docker-devdns

A Dockerized version of @robbiev's https://github.com/robbiev/devdns.

# Usage

This image is based off of the
[google/golang](https://registry.hub.docker.com/u/google/golang/) image.

Run it on port `5300` and have it return `127.0.0.1` for every DNS
request it gets:

```shell
$ docker run -p 5300:5300/udp robmadole/devdns:latest
2015/01/09 17:19:38 Listening on 0.0.0.0:5300, resolving to 127.0.0.1
```

Since DNS works on UDP make sure that you use `/udp` when making the
port mapping.

Now we can query the DNS server with any domain and always get back a
deterministic value.

```shell
$ dig -p 5300 mysite.dev @localhost
```

Or if you're using [Boot2Docker](http://boot2docker.io):

```shell
$ dig -p 5300 mysite.dev @`boot2docker ip`
```

# What next?

If you are using OS X you can create a file inside of `/etc/resolver`
called `dev` and tell it to use your devdns container.

*Tip* use `boot2docker ip` to figure out what IP address you need to
assign `nameserver` to if you are using Boot2Docker.

`/etc/resolver/dev`:

```
nameserver 192.168.59.103
port 5300
```

To change the IP address that it answers with use the `ANSWER`
environment variable.

```shell
$ docker run -e ANSWER=10.9.8.7 -p 5300:5300/udp robmadole/devdns:latest
2015/01/09 18:13:08 Listening on 0.0.0.0:5300, resolving to 10.9.8.7
```
