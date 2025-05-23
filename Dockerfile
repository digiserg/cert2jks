FROM golang:1.24-alpine AS builder

WORKDIR /app
COPY . .

RUN go build -o cert2jks main.go

# ---

FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/cert2jks /app/cert2jks

ENTRYPOINT ["/app/cert2jks", "-config", "/app/config.yaml", "-daemon"]
