+++
title = "k8s_exec_file resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_exec_file"
identifier = "inspec/resources/k8s/K8s Exec File"
parent = "inspec/resources/k8s"
+++

Use the `k8s_exec_file` Chef InSpec audit resource to test the properties of all files within in a pod/container.

## Installation

## Syntax

```ruby
describe k8s_exec_file(path: '/etc/e2scrub.conf', pod: 'shell-demo', namespace: 'default') do
  it { should exist }
end
```

## Parameter

`namespace`
: Namespace of the resource (default: **default**).

`pod`
: Name of the pod

`path`
: Fully Qualified path of the file

`container`
: Name of the container

## Properties

`content`
: content of the files.

`size`
: size of the file.

`basename`
: basename of the file.

`owner`
: owner of the file.

`group`
: File group.

`type`
: file type.

`symlink`
: symlink directory

`mode`
: file mode

`uid`
: UID of the file

## Examples

### Check if path exists and it is a file

```ruby
describe k8s_exec_file(path: '/etc/e2scrub.conf', pod: 'shell-demo', namespace: 'default') do
  it { should exist }
  it { should be_file }
end
```

### check if we have full rights on the file

```ruby
describe k8s_exec_file(path: '/etc/e2scrub.conf', pod: 'shell-demo', namespace: 'default') do
  it { should exist }
  it { should be_file }
  it { should be_readable }
  it { should be_writable }
  it { should be_executable.by_user('root') }
  it { should be_owned_by 'root' }
  its('mode') { should cmp '0644' }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
