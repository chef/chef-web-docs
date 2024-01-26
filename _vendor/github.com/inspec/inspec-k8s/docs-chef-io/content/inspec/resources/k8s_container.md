+++
title = "k8s_container resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_container"
identifier = "inspec/resources/k8s/K8s Container"
parent = "inspec/resources/k8s"
+++


Use the `k8s_container` Chef InSpec audit resource to test the configuration of a specific Container in the specified namespace.

## Installation

## Syntax

```ruby
describe k8s_container(namespace: "NAMESPACE", pod_name: 'POD_NAME', name: "NAME") do
  #...
end
```

## Parameter

`namespace`
: Namespace of the resource.

`pod_name`
: Pod Name of the resource

`container_name`
: Container Name of the resource

## Properties

`name`
: Name of the Container.

`image`
: Container image name.

`command`
: Entrypoint array.

`arg`
: Arguments to the entrypoint.

`resource`
: Compute Resources required by this container.

`volumeMount`
: Pod volumes to mount into the container's filesystem

`livenessProbe`
: Periodic probe of container liveness

`readinessProbe`
: Periodic probe of container service readiness

`imagePullPolicy`
: Image pull policy, One of Always, Never, IfNotPresent

`securityContext`
: Security options the pod should run with

## Examples

### Container for default namespace must exist

```ruby
 describe k8s_container(pod_name: 'POD_NAME', name: 'NAME') do
  it { should exist }
end
```

### Container for a specified namespace must exist

```ruby
describe k8s_container(namespace: 'NAMESPACE', name: 'NAME', pod_name: 'POD_NAME') do
  it { should exist }
end
```

### Check for presence of specific commands in Entrypoint array

```ruby
 describe k8s_container(pod_name: 'POD_NAME', name: 'NAME') do
  it { should_have_command?('COMMAND') }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}
