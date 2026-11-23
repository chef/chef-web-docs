+++
title = "docker_service resource"
draft = false

platform = "linux"

[menu.inspec_6_8]
    title = "docker_service"
    identifier = "resources/core/docker_service.md docker_service resource"
    parent = "resources/core"
+++

Use the `docker_service` Chef InSpec audit resource to verify a docker swarm service.

## Availability

### Install

{{< readfile file="content/inspec/6.8/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.51.0 of InSpec.

## Syntax

A `docker_service` resource block declares the service by name:

```ruby
describe docker_service('foo') do
  it { should exist }
  its('id') { should eq 'docker-service-id' }
  its('repo') { should eq 'alpine' }
  its('tag') { should eq 'latest' }
end
```

## Resource Parameter Examples

The resource allows you to pass in a service id:

```ruby
describe docker_service(id: 'docker-service-id') do
  ...
end
```

You can also pass in the fully-qualified image:

```ruby
describe docker_service(image: 'localhost:5000/alpine:latest') do
  ...
end
```

## Property Examples

The following examples show how to use Chef InSpec `docker_service` resource.

### id

The `id` property returns the service id:

```ruby
its('id') { should eq 'docker-service-id' }
```

### image

The `image` property is a combination of `repository:tag` it tests the value of the image:

```ruby
its('image') { should eq 'alpine:latest' }
```

### mode

The `mode` property tests the value of the service mode:

```ruby
its('mode') { should eq 'replicated' }
```

### name

The `name` property tests the value of the service name:

```ruby
its('name') { should eq 'foo' }
```

### ports

The `ports` property tests the value of the service's published ports:

```ruby
its('ports') { should include '*:8000->8000/tcp' }
```

### repo

The `repo` property tests the value of the repository name:

```ruby
its('repo') { should eq 'alpine' }
```

### replicas

The `replicas` property tests the value of the service's replica count:

```ruby
its('replicas') { should eq '3/3' }
```

### tag

The `tag` property tests the value of image tag:

```ruby
its('tag') { should eq 'latest' }
```

### Test a docker service

```ruby
describe docker_service('foo') do
  it { should exist }
  its('id') { should eq 'docker-service-id' }
  its('repo') { should eq 'alpine' }
  its('tag') { should eq 'latest' }
end
```

## Matchers

{{< readfile file="content/inspec/6.8/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The `exist` matcher tests if the image is available on the node:

```ruby
it { should exist }
```
