# caddy-docker

This repo provides caddy docker image built from sources.

## Usage

A pre-built image is available at Docker Hub: `mozgiii/caddy-docker`.

You should build your own image using this (typically you'd copy `caddy` binary from this image, not use this image as a base image).
Add your own `Caddyfile` and, optionally other files (a statically built SPA code for example).
Adding a CA certificates bundle (to `/etc/ssl/certs/` if you're grabbing one from Mozilla directly, or using your base image's package manager) would also be a good idea, but it's up to you.
This image is built using `alpine` flavor of `golang` image, so it's best to build the final image based on alpine as well. The binary is built with `CGO_ENABLED=0`, so it should work with other base images as well.

## Building

Just build an image as usual with `docker build`.

Supported build args:

- `CADDY_VERSION` - a tag/branch/commit from the http://github.com/mholt/caddy repo.
- `GO_IMAGE` - a go image (has to be alpine-based, because we're installing git).
