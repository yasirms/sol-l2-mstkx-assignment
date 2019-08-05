#!/bin/bash

# Create monitoring namespace
sudo kubectl create namespace monitoring

# Create Cluster role
sudo kubectl create -f clusterRole.yaml

# Create A Config Map
kubectl create -f config-map.yaml -n monitoring


# Create A Prometheus Deployment
kubectl create -f prometheus-deployment.yaml --namespace=monitoring


#Store find name of Prometheus pod:
PROMETHEUS_POD=kubectl get pods --namespace=monitoring | grep prometheus | sed -n '2p' | awk '{print $1}'


# Using Kubectl Port Forwarding
kubectl port-forward $PROMETHEUS_POD 8080:9090 -n monitoring


# Exposing Prometheus As A Service
kubectl create -f prometheus-service.yaml --namespace=monitoring


