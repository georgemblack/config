# Kubernetes Overview

(Notes from an ACloudGuru course.)

Course files can be found [here](https://github.com/ACloudGuru-Resources/Course_Kubernetes_Deep_Dive_NP).

What does it mean to take advantage of Cloud Native?
- Using abstracted technologies (Lambda, etc.)
- Building small components that compose larger systems

## Big Picture

### Control Plane

The **control plane** consists of:

1. API Server (handles vast majority of traffic)
2. Scheduler
3. Controllers
4. Persistent Store (etcd, only stateful part)

### API

API is split/versioned in four primary groups:

1. `core`
2. `apps`
3. `authorization`
4. `storage`

```sh
kubectl get apiservices
```

### Core Objects

- Pod: Wraps one or more containers
- Deployment: Wraps a deployment of pods 
- DaemonSets: Exactly one pod runs on every worker in the cluster
- StatefulSets: Wraps pods with stateful requirements

A lot more!

## Networking

### Overview

Rules:

1. All nodes can talk
2. All pods can talk (no NAT)
3. Every pod gets an IP

There are two primary networks:

1. Node network
2. Pod network

The pod network is one big flat network. A pod sees itself as the same IP that everyone else sees it as! This simplifies a lot.

### Services

Every Service object gets a name and IP. These are stable throughout the life of the service. Name and IP get registered with internal DNS.

If I have a service named `search-api`, now every other service can resolve it.

Services are similar to load balancers – and in the case of cloud-powered K8s, a native cloud load balancer is spun up.

Services have a label selector – i.e. `app=search` to determine which pods to send traffic to on the back-end.

An Endpoint object contains a list of pods that the service can send a request to. Service picks a pod from the endpoint service.

All service types provide a network abstraction for a set of pods:

- LoadBalancer: For deploying a load balancer native to the cloud platform you're using.
- CluserIP: The default. A single IP that is only accessible within the cluster.
- NodePort: Enables access outside the cluster via a cluster-wide port.
  - This is accessible by taking an IP of a node, and appending the port to the end.

## Storage

```sh
kubectl get pv
kubectl get pvc
kubectl get sc
```

Volumes decouple storage from pods. Kubernetes is not bothered by things such as speed, replication, or resiliency – this depends on the backend storage system.

Core objects of PV Subsystem:

* PersistentVolume (PV): A storage resource, as it is represented/tracked in K8s. For example, a specific persistent disk in GCP.
* PersistentVolumeClaim (PVC): The "ticket" for an application to use a PV.
* StorageClass (SC): Makes things dynamic (more below).

**CSI (Container Storage Interface)**: An interface to map storage backends (i.e. AWS EBS) to the K8s API (PVs, PVCs, etc).

By having a standardized interface, I can interact with any storage backend using standard K8s APIs. From the storage backend perspective, features can be exposed to the K8s user is a consistent way.

### Storage Classes

Just using PV and PVCs doesn't scale, and isn't dynamic. Someone would have to go deploy a cloud disk each time someone wants a pod w/storage!

A StorageClass object defines what plugin to use to *provision* storage resources, and paramters for what type of storage to deploy. Storage gets deployed on-demand.

Suppose we have two storage classes, named `fast` and `slow`. Now, when an application creates a PVC, they simply reference one of these names, and storage will be created for them automatically using AWS EBS, for example.

Default storage class: If you create a PVC, but there's no storage class defined, you can use a default storage class! Most cloud platforms configure default classes.

## Deployment

A Deployment handles a single pod – i.e. you can't involve different pods in the same Deployment.

* Pods wrap containers
* Deployments wrap pods
* ReplicaSets can sit between pods and deployments to manage scaling, but since they're managed by the deployment, we don't really see them.

## Scaling

* Horizontal Pod Autoscaler (HPA): An object that increases the replica count for a Deployment on the cluster.
	* One-to-one relationship between HPA and Deployment.
	* Scales based on *actual* values, i.e. CPU utilization.
* Cluster Autoscaler (CA): Scales nodes in the cluster.
	* Scales based on *requested* values (such as resource requests by each pod).
	* Usually implemented by cloud provider.