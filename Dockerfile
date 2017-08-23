FROM scratch
COPY rootfs /
CMD [ "/bin/caddy" ]
