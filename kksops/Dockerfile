FROM golang:alpine AS builder

RUN apk --no-cache add make curl && \
    go install go.mozilla.org/sops/v3/cmd/sops@latest

RUN mkdir /download \
    && curl -L https://dl.k8s.io/release/v1.25.3/bin/linux/amd64/kubectl -o /download/kubectl \
    && curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.5.2/kustomize_v4.5.2_linux_amd64.tar.gz  -o /download/kustomize.tar.gz \
    && tar xzf /download/kustomize.tar.gz -C /download/ \
    && curl -L https://github.com/viaduct-ai/kustomize-sops/releases/download/v3.0.1/ksops_latest_Linux_x86_64.tar.gz  -o /download/ksops.tar.gz \
    && tar xzf /download/ksops.tar.gz -C /download/ \
    && curl -L https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o /download/yq

FROM alpine:3.12
LABEL com.circleci.preserve-entrypoint=true


RUN apk --no-cache add bash curl ca-certificates jq gettext gnupg git make

COPY --from=builder /download/kubectl /usr/local/bin/
COPY --from=builder /download/kustomize /usr/local/bin/
COPY --from=builder /download/ksops /usr/local/lib/kustomize/plugins/viaduct.ai/v1/ksops/ksops
COPY --from=builder /go/bin/sops /usr/local/bin/sops
COPY --from=builder /download/yq /usr/local/bin/yq

ENV KUSTOMIZE_PLUGIN_HOME=/usr/local/lib/kustomize/plugins

COPY entrypoint.sh /
COPY helper.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/yq \
    && chmod +x /usr/local/bin/sops \
    && chmod +x /entrypoint.sh \
    && chmod +x /usr/local/bin/helper.sh

ENTRYPOINT ["/entrypoint.sh"]
