ARG builder_image=build-harbor.alauda.cn/ait/golang:1.20-bullseye
FROM ${builder_image} as builder
WORKDIR /workspace
ARG goproxy=https://proxy.golang.org
ENV GOPROXY=$goproxy
RUN go build main.go

FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /workspace/main .
USER 65532
ENTRYPOINT ["/main"]