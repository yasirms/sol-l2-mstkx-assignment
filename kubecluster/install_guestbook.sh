!#/bin/bash



#Run below commands on Kubemaster  to create Development Namespace

kubectl create namespace development

#Installing guest-book application

kubectl apply -n development -f https://k8s.io/examples/application/guestbook/redis-master-deployment.yaml
kubectl apply -n development -f https://k8s.io/examples/application/guestbook/redis-master-service.yaml
kubectl apply -n development -f https://k8s.io/examples/application/guestbook/redis-slave-deployment.yaml
kubectl apply -n development -f https://k8s.io/examples/application/guestbook/redis-slave-service.yaml
kubectl apply -n development -f https://k8s.io/examples/application/guestbook/frontend-deployment.yaml
kubectl apply -n development -f https://k8s.io/examples/application/guestbook/frontend-service.yaml


