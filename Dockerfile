FROM golang:latest

COPY . . 

RUN go mod init

RUN go mod tidy 

RUN go build -o /go/bin/app

FROM alpine:latest

COPY --from=builder /go/bin/app /app

EXPOSE 8080
CMD ["./app"]