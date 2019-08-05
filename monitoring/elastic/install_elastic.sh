!#/bin/bash

kubectl create namespace logging

# Install Elastic Search
kubectl create -f kubernetes/elastic.yaml -n logging


#Install Kibana
kubectl create -f kubernetes/kibana.yaml -n logging


#Create Fluentd-ROle Base Access Control
kubectl create -f kubernetes/fluentd-rbac.yaml


# Create Fluentd Deployment
kubectl create -f kubernetes/fluentd-daemonset.yaml

