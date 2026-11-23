+++
title = "docker_container resource"
draft = false

platform = "linux"

[menu.inspec_5_23]
    title = "docker_container"
    identifier = "resources/core/docker_container.md docker_container resource"
    parent = "resources/core"
+++

Use the `docker_container` Chef InSpec audit resource to test a Docker container.

## Availability

### Install

This resource is distributed with Chef InSpec.

### Version

This resource is available from the InSpec version 1.21.0.

## Syntax

A `docker_container` resource block declares the configuration data to be tested:

```ruby
describe docker_container('container') do
  it { should exist }
  it { should be_running }
  its('id') { should_not eq '' }
  its('image') { should eq 'busybox:latest' }
  its('repo') { should eq 'busybox' }
  its('tag') { should eq 'latest' }
  its('ports') { should eq [] }
  its('command') { should eq 'nc -ll -p 1234 -e /bin/cat' }
end
```

## Resource Parameter Examples

### name

The container name can be provided with the `name` resource parameter.

```ruby
describe docker_container(name: 'an-echo-server') do
  it { should exist }
  it { should be_running }
end
```

### container id

Alternatively, you can pass in the container id.

```ruby
describe docker_container(id: '71b5df59442b') do
  it { should exist }
  it { should be_running }
end
```

## Property Examples

The following examples show how to use this Chef InSpec resource.

### id

The `id` property tests the container ID.

```ruby
its('id') { should eq 'sha:71b5df59...442b' }
```

### Repo

The `repo` property tests the value of the image repository.

```ruby
its('repo') { should eq 'REPO' }
```

### tag

The `tag` property tests the value of the image tag.

```ruby
its('tag') { should eq 'LATEST' }
```

### ports

The `ports` property tests the value of the Docker ports.

```ruby
its('ports') { should eq '0.0.0.0:1234->1234/tcp' }
```

### command

The `command` property tests the value of the container run command.

```ruby
its('command') { should eq 'nc -ll -p 1234 -e /bin/cat' }
```

### Verify a running container

```ruby
describe docker_container('an-echo-server') do
  it { should exist }
  it { should be_running }
  its('id') { should_not eq '' }
  its('image') { should eq 'busybox:latest' }
  its('repo') { should eq 'busybox' }
  its('tag') { should eq 'latest' }
  its('ports') { should eq [] }
  its('command') { should eq 'nc -ll -p 1234 -e /bin/cat' }
end
```

## Matchers

{{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}
 The specific matchers of this resource are: `exist`, `be_running`, `have_volume?`.

### exist

The `exist` matcher specifies if the container exists.

```ruby
it { should exist }
```

### be_running

The `be_running` matcher checks if the container is running.

```ruby
it { should be_running }
```

### have_volume?

The `have_volume?` matcher checks if the container has mounted volumes.

```ruby
it { should have_volume?(destination_path_in_container, source_path_in_source) }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Ensures container exists

The below test passes if the container `wonderful_wozniak` exists as part of the Docker instances.

```ruby
describe docker_container('wonderful_wozniak') do
  it { should exist }
end
```

### Ensures container is in running status

The below test passes if the container `trusting_williams` exists as part of the Docker instances and the status is running.

```ruby
describe docker_container('trusting_williams') do
  it { should be_running }
end
```

### Ensures container has mounted volumes

The below test passes if the container `quizzical_williamson` exists as part of the Docker instances, the status is running, and has mounted volume on `/app` in the container from the source path of `/var/lib/docker/volumes/volume_2/_data`

```ruby
describe docker_container('quizzical_williamson') do
  it { should have_volume('/app', '/var/lib/docker/volumes/volume_2/_data') }
end
```
