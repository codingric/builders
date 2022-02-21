#!/bin/bash
if [[ ! -z ${KUBERNETES_CONFIG} ]]; then
    mkdir -p ~/.kube
    echo ${KUBERNETES_CONFIG} | base64 -d > ~/.kube/config
    echo Saved kube config
fi

if [[ ! -z ${GPG_ASC} ]]; then
    mkdir -p ~/.gpg
    echo ${GPG_ASC} | base64 -d > ~/.gpg/gpg.asc
    gpg --import ~/.gpg/gpg.asc
    echo GPG keys imported
fi

if [[ -z ${KUBERNETES_CONFIG} ]] && [[ -z ${GPG_ASC} ]]; then
    printenv
    exit 1
fi