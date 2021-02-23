#!/bin/bash
ECHO "Starting kubernetes instance for WVB"
ECHO "Starting minikube"
#minikube start
ECHO "Enter path to vb_django repo: "
read django_path
ECHO "Enter path to app_data repo: "
read data_path
ECHO "Mounting vb_django directory from: $django_path"
ECHO "Mounting app_data directory from: $data_path"
start "Mounting vb_django" minikube mount $django_path:/host/vb_django
start "Mounting data_path" minikube mount $data_path:/host/app_data
start "minikube dashboard" minikube dashboard
timeout /T 30
ECHO "Applying WVB kubernetes elements"
kubectl apply -f vb-postgresql.yml
kubectl apply -f vb-dask.yml
kubectl apply -f vb-django.yml
#start "minikube url" minikube service --url vb-django
start "minikube tunnel" minikube tunnel
ECHO "Completed kuberenetes startup of WVB"