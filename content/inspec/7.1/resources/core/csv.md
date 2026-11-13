+++
title = "csv resource"
draft = false

platform = "os"

[menu.inspec_7_1]
    title = "csv"
    identifier = "resources/core/csv.md csv resource"
    parent = "resources/core"
+++

Use the `csv` Chef InSpec audit resource to test configuration data in a CSV file.

## Availability

### Install

{{< readfile file="content/inspec/7.1/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `csv` resource block declares the configuration data to be tested:

```ruby
describe csv('file', true) do
  its('name') { should cmp 'foo' }
end
```

Test `csv` file without headers

```ruby
describe csv('file', false).params do
  its([0]) { should cmp 'name' }
end
```

where:

- `'file'` is the path to a CSV file
- `true` or `false` tests a CSV file with or without headers. Default value: `true`.
- `name` is a configuration setting in a CSV file
- `should eq 'foo'` tests a value of `name` as read from a CSV file versus the value declared in the test
- `params` is the method for fetching data from a CSV file without headers.
- `[0]` is the array element position.

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a CSV file without headers

```ruby
describe csv('some_file.csv', false).params do
  its([0]) { should eq ["name"] }
end
```

### Test a CSV file

```ruby
describe csv('some_file.csv') do
  its('setting') { should eq 1 }
end
```

## Property Examples

### name

The `name` property tests the value of `name` as read from a CSV file compared to the value declared in the test.

```ruby
its('name') { should cmp 'foo' }
```

## Matchers

{{< readfile file="content/inspec/7.1/reusable/md/inspec_matchers_link.md" >}}
