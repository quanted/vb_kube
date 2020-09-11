# Virtual Beach Web - Kubernetes

Virtual Beach Web is an analytical prediction making tool using statistical and machine learning techniques through a dynamic web user interface. The application is fully containerized and deployed using kubernetes for container orchestration. The full technology stack contains the following components:
  - Django (web framework)
  - Angular 8 (graphical user interface, served through django)
  - PostgreSQL (django database)
  - Dask (asynchronous and distributed tasks)
 
#### Docker Builds
| Deployment | Docker Image | Build Status |
| ---------- | ------------ | ------------ | 
| vb-django.yml | [quanted/vb_django](https://cloud.docker.com/u/quanted/repository/docker/quanted/vb_django) | ![Docker Build Status](https://img.shields.io/docker/cloud/build/quanted/vb_django.svg) |
| vb-dask.yml | [quanted/vb_dask ](https://cloud.docker.com/u/quanted/repository/docker/quanted/vb_dask) | ![Docker Build Status](https://img.shields.io/docker/cloud/build/quanted/vb_dask.svg) |
| vb-postgres.yml | [postgres ](https://cloud.docker.com/u/quanted/repository/docker/postgres) | Official Image |

#### Requirements
 - TODO

#### Minikube Development (Windows)
 - TODO
 - Powershell (as admin)

##### Minikube Volumes (Windows)
Using Minikube and Hyper-V, an additional step is required to properly mount the volumes used by the kubernetes deployments. Two volumes must be mounted to the minikube host, the vm created in Hyper-V. After minikube has been started and is running, run the following two commands in two separate powershell (as admin) terminals:
```
    minikube mount PATH_TO_APP_DATA:/host/app_data
    minikube mount PATH_TO_VB_DJANGO:/host/vb_django
```
