# mStakx Assignment

This readme file describes the overall solution to the mStakx excercise - Level 2

The solution for each task has been created using multiple file. This file will cover the highlight of each solution on top and then the README file in each folder will describe the steps taken to complete the specific task.

## Task 1: Create a Highly available Kubernetes cluster manually using Google Compute Engines (GCE).

The README file ./kubecluster/README.MD describes steps in detail on how the cluster has been setup.

## Task 2: Create a CI/CD pipeline using Jenkins (or a CI tool of your choice) outside Kubernetes cluster (not as a pod inside Kubernetes cluster).

The README file inside ./jenkins/ folder describes the process to implement to jenkins server and CI/CD Pipeline


## Task 3: Create a development namespace

The script ./kubcluster/create_ns_development.sh does the job.


## Task 4 : Deploy guest-book application in the development Namespcae

The scipt ./kubcluster/install_guestbook.sh does the job

## Task 5: Install and Configure Helm in the Cluster

The script ./kubecluster/install_helm.sh does the job.


## Task 6: Use Helm to deploy the application on Kubernetes Cluster from CI server

The script ./kubecluster/app_with_helm.sh does the job

## Task 7: Create a monitoring namespace in the cluster

The script ./kubecluster/create_ns_monitoring.sh does the job


## Task 8: Setup Prometheus (in monitoring namespace) for gathering host/container metrics along with health check status of the application.

The script ./monitoring/prometheus/install_prometheus.sh does the job


## Task 9: Create a dashboard using Grafana to help visualize the Node/Container/API Server etc. metrices from Prometheus server. Optionally create a custom dashboard on Grafana


https://grafana.com/grafana/dashboards/7082
https://grafana.com/grafana/dashboards/1471


## Task 10: Setup log analysis using Elasticsearch, Fluentd (or Filebeat), Kibana.

Check out the script at ./monitoring/elastic/install_elastic.sh. Please note that this installation has sourced YAML files from below git repo:

https://github.com/mjhea0/efk-kubernetes



## Task 11: Demonstrate Blue/Green and Canary deployment for the application (For e.g. Change the background color or font in the new version etc.,)

 
I had previosuly built a Canary deployment for another assignment. Please check my work here: 

https://github.com/yasirms/kpn



## Task 12: Write a wrapper script (or automation mechanism of your choice) which does all the steps above.





## Task 13: Document the whole process in a README file at the root of your repo. Mention any pre-requisites in the README





