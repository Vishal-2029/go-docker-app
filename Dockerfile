# 1. Builder stage
FROM golang:1.23.5-alpine AS builder


WORKDIR /app
COPY . .
RUN go build -o  main.go

# 2. Final image
FROM alpine:latest
COPY --from=builder /app/main.go /app

EXPOSE 8080
CMD ["/app"]
