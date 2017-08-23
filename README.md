# caddy-docker

This repo provides tooling to build caddy docker image from scratch.

It will generate rootfs that only includes `bin/caddy` (the caddy binary).
Use it as a base for your own more specific docker image.

You should add your own `Caddyfile` for the server to work.
Adding a CA certificates bundle to `/etc/ssl/certs/` (from Mozilla i.e.) would also be a good idea, but it's up to you.

## Usage

First create rootfs:

```shell
bin/create-rootfs
```

Then you can use rootfs on it's own or build a docker image from it:

```shell
bin/build-docker-image my-image-tag
```

Now you have a docker image with `bin/caddy`.
