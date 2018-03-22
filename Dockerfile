ARG GO_IMAGE=golang:1.10-alpine

FROM "${GO_IMAGE}" AS builder

# Install git.
RUN apk add --no-cache git

ARG CADDY_VERSION=v0.10.11
ARG CADDY_BUILDS_VERSION=c62e2219460a8828970dad09212c3a4cec40b56c

# Download and build caddy (from source).
RUN go get -v -d github.com/mholt/caddy/caddy \
  && go get -v -d github.com/caddyserver/builds \
  # Set github.com/mholt/caddy version
  && cd /go/src/github.com/mholt/caddy \
  && git checkout -f -b build "${CADDY_VERSION}" \
  # Set github.com/caddyserver/builds version
  && cd /go/src/github.com/caddyserver/builds \
  && git checkout -f -b build "${CADDY_BUILDS_VERSION}" \
  # Build the code
  && cd /go/src/github.com/mholt/caddy/caddy \
  && CGO_ENABLED=0 go run build.go \
  # Move binary to the expected location
  && mv caddy /usr/local/bin/ \
  # Cleanup
  && cd / \
  && rm -rf /go/src/* /go/bin/* /go/pkg

# Construct the image.
FROM scratch
WORKDIR /
COPY --from=builder /usr/local/bin/caddy /usr/local/bin/caddy
CMD [ "caddy" ]
EXPOSE 2015
