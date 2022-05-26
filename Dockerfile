# builder image
FROM golang:1.18.2-alpine3.15 as builder

# the work directory to be build 
WORKDIR /build

COPY go.mod ./
COPY go.sum ./
# install the modules necessary to compile it
RUN go mod download

# copy all to build file
COPY . ./
RUN go mod vendor
# project will now successfully build with the necessary go libraries included. 
RUN go build -o  app .


# generate clean, final image for end users
FROM alpine:3.11.3
WORKDIR /app
COPY --from=builder /build /app/

EXPOSE 8080

# executable
ENTRYPOINT [ "./app" ]