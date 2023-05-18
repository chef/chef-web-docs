+++
title = "k8s_containers resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_containers"
identifier = "inspec/resources/k8s/K8s Containers"
parent = "inspec/resources/k8s"
+++

Use the `k8s_containers` Chef InSpec audit resource to test the configurations of all Containers in a namespace.

## Installation

## Syntax

```ruby
describe k8s_containers do
  #...
end
```

## Parameter

`namespace`
: Namespace of the resource.

## Properties

`names`
: Name of the Container.

`images`
: Container image name.

`commands`
: Entrypoint array.

`args`
: Arguments to the entrypoint.

`resources`
: Compute Resources required by this container.

`volumeMounts`
: Pod volumes to mount into the container's filesystem

`livenessProbes`
: Periodic probe of container liveness

`readinessProbes`
: Periodic probe of container service readiness

`imagePullPolicies`
: Image pull policy, One of Always, Never, IfNotPresent

`securityContexts`
: Security options the pod should run with

## Examples

### Containers for default namespace must exist

```ruby
 describe k8s_containers do
  it { should exist }
end
```

### Containers for specified namespace must exist

```ruby
describe k8s_containers(namespace: 'kube-system') do
  it { should exist }
end
```

### Containers with readOnlyRootFilesystem exists

```ruby
describe k8s_containers(namespace: 'kube-system').where{ securityContext && securityContext[:readOnlyRootFilesystem] == true } do 
  it { should exist }
end

```

## Matchers

{{% inspec/inspec_matchers_link %}}
