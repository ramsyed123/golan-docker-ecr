FROM golang:latest AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
COPY *.go ./

RUN go mod tidy


RUN go build -o /golan-docker-ecr

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /golan-docker-ecr /golan-docker-ecr

USER nonroot:nonroot

ENTRYPOINT ["/golan-docker-ecr"]