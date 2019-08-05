#!/bin/bash

#filename: app_with_helm.sh
# The following command install consul app on the kubernetes cluster
helm install --name consul-app stable/consul