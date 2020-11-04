+++
title = "Kubernetes"
description = "Export your Chef Habitat package as a Docker and run it on a Kubernetes Pod"

[menu]
  [menu.habitat]
    title = "Kubernetes"
    identifier = "habitat/containers/kubernetes Kubernetes Development Patterns"
    parent = "habitat/containers"
    weight = 30

+++
[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/kubernetes.md)

[Kubernetes](https://kubernetes.io/) is an open source container cluster manager that is available as a stand-alone platform or embedded in several distributed platforms including [Google's Container Engine](https://cloud.google.com/container-engine/), [AWS Elastic Kubernetes Service](https://aws.amazon.com/eks/), [Azure Kubernetes Service](https://azure.microsoft.com/services/kubernetes-service/), and [Red Hat OpenShift](https://openshift.com/).
Chef Habitat and Kubernetes are complementary. While Kubernetes provides a platform for deployment, scaling, and operations of application containers across clusters of hosts, Chef Habitat manages the build pipeline and lifecycle of those application containers.

## Chef Habitat on Kubernetes

Chef Habitat can export your package as a Docker container that runs on Kubernetes in the form of a pod.
Additionally, a Chef Habitat bastion pod provides essential gossip ring features like service discovery (binds), secrets and the required [initial peer]({{< relref "sup_networks" >}}) to all other pods.

Chef Habitat robustly deploys the bastion pod with a Kubernetes stateful set, persistent volume, and liveness checking, which ensures node availability and ring data persistence. The Kubernetes stateful set comes with an attached Kubernetes service that makes discoverable with DNS. Each namespace should contain a single service and stateful set.

## Deploy the Chef Habitat Bastion on Kubernetes

Complete examples may be downloaded from [this folder]({{< relref "pattern_library#kubernetes-bastion-ring-pattern" >}})

To explain how this works, let's break down the hab-bastion.yaml file:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: hab-bastion
spec:
  ports:
  - name: gossip-listener
    protocol: UDP
    port: 9638
    targetPort: 9638
  - name: http-gateway
    protocol: TCP
    port: 9631
    targetPort: 9631
  selector:
    app: hab-bastion
  clusterIP: None
```

This service definition creates a virtual IP (VIP), opening access to the Chef Habitat service that runs on the pod.
- The habitat gossip port (9638/UDP) listener
- The habitat http-gateway (9631/TCP) listener
- makes service name available in DNS (as `hab-bastion` or `hab-bastion.namespace-name`, etc) and discoverable by any pod

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: hab-bastion
spec:
    spec:
      securityContext:
        fsGroup: 42
```

This section sets the group ownership for the persistent volume mount point so the Habitat Supervisor can write to it.  The Habitat user (`hab`) by default has the uid `42` and the gid `42`.

```yaml
      containers:
      - name: hab-bastion
        image: mydockerorigin/hab_bastion:latest
        args:
        - '--permanent-peer'
```

The `image:` line defines the source of the docker container. In this case, the instructions create an image from a Chef Habitat plan using the `hab pkg export docker` command. It only runs the Chef Habitat Supervisor (hab-sup) service.
The argument `--permanent-peer` instructs the Supervisor to act as a permanent peer.

```yaml
        resources:
          requests:
            memory: "100Mi"
            cpu: "100m" # equivalent to 0.1 of a CPU core
```

Resource requests are important because they give instructions to the Kubernetes scheduler--without them, you might overload some nodes while under-using others.

```yaml
        ports:
        - name: gossip-listener
          protocol: UDP
          containerPort: 9638
        - name: http-gateway
          protocol: TCP
          containerPort: 9631
        readinessProbe:
          httpGet:
            path: /
            port: 9631
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /
            port: 9631
          initialDelaySeconds: 15
          periodSeconds: 20
```

The `livenessProbe` tells Kubernetes if the pod is healthy or not.  If not, the pod gets restarted.
The `readinessProbe` signals to Kubernetes that the pod has started up successfully.

```yaml
        volumeMounts:
        - name: hab-bastion
          mountPath: /hab/sup
  volumeClaimTemplates:
  - metadata:
      name: hab-bastion
    spec:
      accessModes: [ "ReadWriteOnce" ]
      # uncomment if you don't have a default StorageClass
      # storageClassName: "standard"
      resources:
        requests:
          storage: 10Gi
```

All of the Habitat Supervisor's state data is stored under `/hab/sup` - we mount this on a persistent volume so it gets re-attached if the pod is ever rescheduled. The data persists!

## Create a Kubernetes Deployment That Works with the Bastion

The following is an example of a Kubernetes `Stateful Set` built from the CockroachDB plan. The Bastion pattern uses the `--peer hab-bastion` configuration arguments to instruct the Kubernetes pods to use the `hab-bastion` service as a DNS-resolvable host name.

```yaml
+++
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: cockroachdb
spec:
  selector:
    matchLabels:
      app: cockroachdb
  serviceName: cockroachdb
  replicas: 3
  template:
    metadata:
      labels:
        app: cockroachdb
    spec:
      terminationGracePeriodSeconds: 10
      securityContext:
        fsGroup: 42
      containers:
      - name: cockroachdb
        image: irvingpop/cockroach:latest
        args:
        - --peer
        - hab-bastion
        - --topology
        - leader
        resources:
          requests:
            memory: "300Mi"
            cpu: "500m"
        ports:
        - name: http
          containerPort: 8080
        - name: cockroachdb
          containerPort: 26257
        volumeMounts:
        - name: cockroachdb-data
          mountPath: /hab/svc/cockroach/data
  volumeClaimTemplates:
  - metadata:
      name: cockroachdb-data
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 10Gi
```

## Bare Kubernetes

If your packages don't require communication with the Chef Habitat Supervisor ring, such as binds, secrets, etc., then you can execute your packages directly on the cluster. You can deploy Chef Habitat packages exported as containers to Kubernetes with the [`kubectl` command](http://kubernetes.io/docs/user-guide/pods/single-container/). Using the [Docker exporter]({{< relref "pkg_exports#exporting-to-docker" >}}) to create a containerized application, you can launch the container like this example:

```shell
$ kubectl run mytutorial --image=myorigin/mytutorial --port=8080
```

Assuming you're using the Docker image pulled from `myorigin/mytutorial`, port 8080 on the container should be accessible. Pass networking ports exposed by Chef Habitat with `kubectl run` as `--port` options. In this example, the `kubectl get` command is:

```shell
$ kubectl get pods -l run=mytutorial
```

## Docker and ACI

Chef Habitat packages can be exported in both Docker and ACI formats (as well as others). Kubernetes currently supports the Docker runtime and integration of the rkt container runtime (an implementation of the App Container spec) is under active development.

## Environment Variables and Networking

Kubernetes supports passing [environment variables](https://kubernetes.io/docs/user-guide/environment-guide/) into containers.

## Related Reading

* [Export a Chef Habitat package]({{< relref "pkg_exports" >}})
* [Chef Habitat CLI]({{< relref "habitat_cli" >}})
