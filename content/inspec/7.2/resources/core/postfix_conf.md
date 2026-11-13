+++
title = "postfix_conf resource"
draft = false

platform = "os"

[menu.inspec_7_2]
    title = "postfix_conf"
    identifier = "resources/core/postfix_conf.md postfix_conf resource"
    parent = "resources/core"
+++

Use the `postfix_conf` Chef InSpec audit resource to test the main configuration of the Postfix Mail Transfer Agent.

## Availability

### Install

{{< readfile file="content/inspec/7.2/reusable/md/inspec_installation.md" >}}

### Version

## Syntax

A `postfix_conf` resource block declares the configuration settings to be tested:

```ruby
describe postfix_conf do
  its('setting_name') { should cmp 'value' }
end
```

where:

- `'setting_name'` is a setting key defined in main.cf
- `{ should cmp 'value' }` is the value to be expected

When using `postfix_conf` with a custom configuration directory, the following syntax can be used:

```ruby
describe postfix_conf('path') do
  ...
end
```

where:

- `'path'` is the path to your Postfix configuration (ex. '/etc/path/to/postfix/main.cf')

## Properties

This resource supports any of the settings listed in the main.cf file as properties.

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test basic Postfix configuration settings in the main.cf file

For example, the following Postfix configuration:

```plain
/etc/postfix/main.cf:
	myorigin = $myhostname
	myhostname = host.local.domain
	mynetworks = 127.0.0.0/8
```

can be tested like this:

```ruby
describe postfix_conf do
  its('myorigin') { should cmp '$myhostname' }
  its('myhostname') { should cmp 'host.local.domain' }
  its('mynetworks') { should cmp '127.0.0.0/8' }
end
```

## Matchers

{{< readfile file="content/inspec/7.2/reusable/md/inspec_matchers_link.md" >}}
