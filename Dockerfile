# First stage: Build the Go app
FROM golang:1.21.6-alpine3.20 AS builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN apk update && apk upgrade && go mod download

COPY . ./
RUN go build -o /go/bin/app

# Second stage: Minimal image
FROM alpine:3.20

RUN apk update && apk upgrade

COPY --from=builder /go/bin/app /app

EXPOSE 8080

ENTRYPOINT ["/app"]
