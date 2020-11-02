+++
title = "Chef Habitat and Container Orchestration"
description = "Chef Habitat and Container Orchestration"

[menu]
  [menu.habitat]
    title = "Chef Habitat and Container Orchestration"
    identifier = "habitat/containers/habitat-and-orchestration"
    parent = "habitat/containers"

+++

**Example: [Kubernetes](https://kubernetes.io/)**

Kubernetes is a portable, extensible open-source platform for managing containerized workloads and services that has declarative configuration and automation. Applications are run within Docker containers, grouped into pods. Kubernetes provides the control plane and API layer to schedule those pods.

Chef Habitat is not a scheduling tool, and does not schedule container resources such as replicas, deployments, firewalls, networking, geo-location (affinity), etc. Instead, Chef Habitat's responsibility is the service running inside the container. The [Chef Habitat Supervisor](https://www.habitat.sh/docs/using-habitat/#overview) provides topologies, application binding, ring encryption, and dynamic configuration and other features not present in Kubernetes.

Since Chef Habitat and Kubernetes are both able to manage services, using the [Chef Habitat Operator](https://www.habitat.sh/get-started/kubernetes/) with Kubernetes empowers users to use Chef Habitat's runtime features by operating in a Kubernetes native way. Where Chef Habitat and Kubernetes overlap, the Chef Habitat Operator defers control to Kubernetes.

