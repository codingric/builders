# KKSOPS

Image to use whe deployments to kubectl with kustomize with sops is required.

## helper.sh

Looks for `KUBERNETES_CONFIG` variable to be a base64 encoded kube config.
Its decodes and saves in `~/.kube/config`.

Looks for `GPG_ASC` variable to be a base64 encoded exported GPG key. It decodes
it and saves it to  `~/.gpg/gpg.asc` and imports it.