+++
title = "parse_config resource"
draft = false

platform = "os"

[menu.inspec_5_24]
    title = "parse_config"
    identifier = "resources/core/parse_config.md parse_config resource"
    parent = "resources/core"
+++

Use the `parse_config` Chef InSpec audit resource to test arbitrary configuration files.

## Availability

### Install

{{< readfile file="content/inspec/5.24/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `parse_config` resource block declares the location of the configuration setting to be tested, and then what value is to be tested. Because this resource relies on arbitrary configuration files, the test itself is often arbitrary and relies on custom Ruby code:

```ruby
output = command('some-command').stdout

describe parse_config(output, { data_config_option: value } ) do
  its('setting') { should eq 1 }
end
```

or:

```ruby
audit = command('/sbin/auditctl -l').stdout
  options = {
    assignment_regex: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
    multiple_values: true
  }

describe parse_config(audit, options) do
  its('setting') { should eq 1 }
end
```

where each test

- Must declare the location of the configuration file to be tested
- Must declare one (or more) settings to be tested
- May run a command to `stdout`, and then run the test against that output
- May use options to define how configuration data is to be parsed

## Options

This resource supports multiple options to parse configuration data. Use the options in an `options` block stated outside of (and immediately before) the actual test. For example:

```ruby
options = {
    assignment_regex: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
    multiple_values: true
  }

output = command('some-command').stdout

describe parse_config(output,  options) do
  its('setting') { should eq 1 }
end
```

### assignment_regex

Use `assignment_regex` to test a key value using a regular expression:

```ruby
'key = value'
```

may be tested using the following regular expression, which determines assignment from key to value:

```ruby
assignment_regex: /^\s*([^=]*?)\s*=\s*(.*?)\s*$/
```

### comment_char

Use `comment_char` to test for comments in a configuration file:

```ruby
comment_char: '#'
```

### key_values

Use `key_values` to test how many values a key contains:

```ruby
key = a b c
```

contains three values. To test that value to ensure it only contains one, use:

```ruby
key_values: 1
```

### multiple_values

Use `multiple_values` if the source file uses the same key multiple times. All values will be aggregated in an array:

```ruby
# # file structure:
# key = a
# key = b
# key2 = c
params['key'] = ['a', 'b']
params['key2'] = ['c']
```

To use plain key value mapping, use `multiple_values: false`:

```ruby
# # file structure:
# key = a
# key = b
# key2 = c
params['key'] = 'b'
params['key2'] = 'c'
```

### standalone_comments

Use `standalone_comments` to parse comments as a line, otherwise inline comments are allowed:

```ruby
'key = value # comment'
params['key'] = 'value # comment'
```

Use `standalone_comments: false`, to parse the following:

```ruby
'key = value # comment'
params['key'] = 'value'
```

## Examples

This resource is based on the `parse_config_file` resource. See the [`parse_config_file`](/inspec/5.24/resources/core/parse_config_file) resource for examples.

## Matchers

{{< readfile file="content/inspec/5.24/reusable/md/inspec_matchers_link.md" >}}
