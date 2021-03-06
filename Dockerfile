FROM golang:1.16-alpine as builder
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 go build -a -o render-drawio ./cmd/render-drawio

FROM rlespinasse/drawio-desktop-headless:1.0.1
# Enables README support, etc. in Github Packages. See: https://docs.github.com/en/packages/guides/about-github-container-registry
LABEL org.opencontainers.image.source https://github.com/racklet/render-drawio-action

COPY --from=builder /build/render-drawio /
ENTRYPOINT ["/render-drawio"]
