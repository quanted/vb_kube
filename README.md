# Virtual Beach Web - Kubernetes

Virtual Beach Web is an analytical prediction making tool using statistical and machine learning techniques through a dynamic web user interface. The application is fully containerized and deployed using kubernetes for container orchestration. The full technology stack contains the following components:
  - Django (web framework)
  - Angular 10 (graphical user interface, served through django)
  - PostgreSQL (django database)
  - Dask (asynchronous and distributed tasks)
 
#### Docker Builds
| Deployment | Docker Image | Build Status |
| ---------- | ------------ | ------------ | 
| vb-django.yml | [quanted/vb_django](https://cloud.docker.com/u/quanted/repository/docker/quanted/vb_django) | ![Docker Build Status](https://img.shields.io/docker/cloud/build/quanted/vb_django.svg) |
| vb-dask.yml | [quanted/vb_dask ](https://cloud.docker.com/u/quanted/repository/docker/quanted/vb_dask) | ![Docker Build Status](https://img.shields.io/docker/cloud/build/quanted/vb_dask.svg) |
| vb-postgres.yml | [postgres ](https://cloud.docker.com/u/quanted/repository/docker/postgres) | Official Image |

#### Requirements
 - Python 3.8
 - Conda environment yml can be found in vb_django/environment.yml
 - pip requirements txt can be found in vb_django/install_requirements.txt (windows)

#### Minikube Development (Windows)
 - Docker
 - Minikube
 - Administrative access

Minikube for windows, using docker, can be started by running the following command:
```
    minikube start --driver=docker --cpus=CPUS --memory=RAMGb 
```
Once minikube has successfully started, the kubectl commands will now use the configured minikube environment. All documented kubectl commands are available, such as
```
    kubectl apply -f vb-django.yml
    kubectl get pods
    kubectl describe hpa
```
The minikube/kubernetes dashboard can also be accessed for testing, monitoring and setup
```
    minikube dashboard
```
To access a deployment/pod within your minikube node, open up a tunnel access point using the following command, where SERVICE would be vb-django for vb_kube.
```
    minikube service --url SERVICE
```


##### Minikube Volumes (Windows)
Using Minikube on windows with deployments that use mounted volumes requires an additional step to be able to access those volumes. Two volumes must be mounted to the minikube host, the container created in Docker. 
After minikube has been started and is running, run the following two commands in two separate cmd windows terminals, as admin:
```
    minikube mount PATH_TO_APP_DATA:/host/app_data
    minikube mount PATH_TO_VB_DJANGO:/host/vb_django
```
These windows will need to be left active for the mounts to remain accessible.

##### Docker-Desktop (Windows)

```commandline
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
kubectl proxy
```
Kubernetes dashboard is accessible from: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
