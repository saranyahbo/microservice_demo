FROM golang:1.17-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /microservice_demo

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /microservice_demo /microservice_demo

USER nonroot:nonroot

ENTRYPOINT ["/microservice_demo"]
