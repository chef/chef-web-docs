+++
title = "kernel_module resource"
draft = false

platform = "linux"

[menu.inspec_7_1]
    title = "kernel_module"
    identifier = "resources/core/kernel_module.md kernel_module resource"
    parent = "resources/core"
+++

<!-- vale chef.inclusive = NO -->

Use the `kernel_module` Chef InSpec audit resource to test kernel modules on Linux
platforms. These parameters are located under `/lib/modules`. Any submodule may
be tested using this resource.

The `kernel_module` resource can also verify if a kernel module is `blacklisted`
or if a module is disabled with a fake install using the `bin_true` or `bin_false`
method.

## Availability

### Install

{{< readfile file="content/inspec/7.1/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `kernel_module` resource block declares a module name, and then tests if that
module is a loaded kernel module, if it's enabled, disabled or if it's
blacklisted:

```ruby
describe kernel_module('module_name') do
  it { should be_loaded }
  it { should_not be_disabled }
  it { should_not be_blacklisted }
end
```

where:

- `'module_name'` must specify a kernel module, such as `'bridge'`
- `{ should be_loaded }` tests if the module is a loaded kernel module
- `{ should be_blacklisted }` tests if the module is blacklisted or if the module is disabled with a fake install using /bin/false or /bin/true
- `{ should be_disabled }` tests if the module is disabled with a fake install using /bin/false or /bin/true

## Examples

The following examples show how to use this Chef InSpec audit resource.

### version

The `version` property tests if the kernel module on the system has the correct version:

```ruby
its('version') { should eq '3.2.2' }
```

### Test a kernel module's 'version'

```ruby
describe kernel_module('bridge') do
  it { should be_loaded }
  its('version') { should cmp >= '2.2.2' }
end
```

### Test if a kernel module is loaded, not disabled, and not blacklisted

```ruby
describe kernel_module('video') do
  it { should be_loaded }
  it { should_not be_disabled }
  it { should_not be_blacklisted }
end
```

### Check if a kernel module is blacklisted

```ruby
describe kernel_module('floppy') do
  it { should be_blacklisted }
end
```

### Check if a kernel module isn't blacklisted and is loaded

```ruby
describe kernel_module('video') do
  it { should_not be_blacklisted }
  it { should be_loaded }
end
```

### Check if a kernel module is disabled with `bin_false`

```ruby
describe kernel_module('sstfb') do
  it { should_not be_loaded }
  it { should be_disabled }
end
```

### Check if a kernel module is 'blacklisted'/'disabled' with 'bin_true'

```ruby
describe kernel_module('nvidiafb') do
  it { should_not be_loaded }
  it { should be_blacklisted }
end
```

### Check if a kernel module isn't loaded

```ruby
describe kernel_module('dhcp') do
  it { should_not be_loaded }
end
```

## Matchers

{{< readfile file="content/inspec/7.1/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_blacklisted

The `be_blacklisted` matcher tests if the kernel module is a blacklisted module:

```ruby
it { should be_blacklisted }
```

### be_disabled

The `be_disabled` matcher tests if the kernel module is disabled:

```ruby
it { should be_disabled }
```

### be_loaded

The `be_loaded` matcher tests if the kernel module is loaded:

```ruby
it { should be_loaded }
```
