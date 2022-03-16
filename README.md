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

Docker-Desktop is an alternative option for running a single-node kubernetes cluster. After installing Docker-Desktop, or updating to the latest version, turn Kubernetes on in Settings and restart docker-desktop. A new kubernetes context will be created 'docker-desktop' which can be used to run the stack.

To allow for the mounts, the mounted directories need to be specified or be a sub-directory of a directory which docker-desktop has access to 'Resources > File Sharing'. The compute resources which are specified are the max that the kubernetes cluster will have access to.
Depending on existing kubectl configurations, the new context may need to be set as current.
```commandline
kubectl config current-context
```
If 'docker-desktop' is not the current config, check to see if it is listed in the available contexts
```commandline
kubectl config get-contexts
```
if available, set 'docker-desktop' to the current context by
```commandline
kubectl config set-context docker-desktop
```
or
```commandline
kubectl config use-context docker-desktop
```
Now any kubectl will use the docker-desktop context, the kubernetes resources for vb can now be applied.

For local development the hostPath:path: for the vb-django-volume in vb-django-deployment.yml and the hostPath:path: for the vb-dask-volume in vb-dask-worker-deployment.yml need to be changed to the path to the local vb_kube/vb_django folder. For example:
```yml
volumes:
        - name: vb-django-volume
          hostPath:
            #          path: /host/vb_django
            path: /C//path_to_the_cloned_repo/vb_kube/vb_django
```
The order to apply the resources should be: ConfigMap, PersistentVolumes, PersistentVolumeClaims, Services, StatefulSet, Deployments, HPAs.
Or to apply all the kubernetes manifests for the application at once, run the following from the root of the repo:
```commandline
kubectl apply -f k8s\
```
To create the resources for the  kubernetes dashboard, run the following commands
```commandline
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
kubectl proxy
```
The resources necessary for the dashboard are now running, and can be accessed at:
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

The first time reaching the dashboard will prompt for a login token or key, to skip this step open the kubernetes-dashboard deployment for editing 
```commandline
kubectl edit deploy/kubernetes-dashboard -n kubernetes-dashboard
```
and add the following line under spec.containers.args after the others in the list of args:
```yaml
- --enable-skip-login
```
Those changes will automatically apply once the editing is completed and the yaml is valid. Then revisiting or reloading the dashboard will again prompt for a token/login but also have the option to skip.

Django and Dask have optional hostPath mounts which can be used for local code development and testing, code is mounted directly to the pod so no image rebuilds required (typically requires a pod restart).
To use these hostPaths make sure that the 'vb-django-volume' Volume and VolumeMount blocks are both uncommented. If the hostPath mounts are not used, Django and Dask will use the current code in the image being used (most likely the last commit to github on the main branch).

To access the running technology stack, we can access the open NodePort on vb-nginx that is specified to be port 31000. http://localhost:31000/vb will open up the web application, alternatively http requests can be made to the same base url via Postman or curl.
 
Resource metrics can also be tracked by deploying the metric-server
```commandline
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```
