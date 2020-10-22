+++
title = "parse_config_file resource"
draft = false
platform = "os"

[menu]
  [menu.inspec]
    title = "parse_config_file"
    identifier = "inspec/resources/os/parse_config_file.md parse_config_file resource"
    parent = "inspec/resources/os"
+++

[\[edit on GitHub\]](https://github.com/inspec/inspec/blob/master/docs-chef-io/content/inspec/resources/parse_config_file.md)

Use the `parse_config_file` Chef InSpec audit resource to test arbitrary configuration files. It works in the same way as `parse_config`. Instead of using a command output, this resource works with files.

## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `parse_config_file` Chef InSpec audit resource block declares the location of the configuration file to be tested, and then which settings in that file are to be tested.

    describe parse_config_file('/path/to/file', { data_config_option: value } ) do
      its('setting') { should eq 1 }
    end

or:

    options = {
      assignment_regex: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
      multiple_values: true
    }

    describe parse_config_file('path/to/file', options) do
      its('setting') { should eq 1 }
    end

where each test

- Must declare the location of the configuration file to be tested
- Must declare one (or more) settings to be tested
- May run a command to `stdout`, and then run the test against that output
- May use options to define how configuration data is to be parsed

## Options

This resource supports the following options for parsing configuration data. Use them in an `options` block stated outside of (and immediately before) the actual test:

    options = {
        assignment_regex: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
        multiple_values: true
      }
    describe parse_config_file('path/to/file',  options) do
      its('setting') { should eq 1 }
    end

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a configuration setting

    describe parse_config_file('/path/to/file.conf') do
     its('PARAM_X') { should eq 'Y' }
    end

### Use options, and then test a configuration setting

    describe parse_config_file('/path/to/file.conf', { multiple_values: true }) do
     its('PARAM_X') { should include 'Y' }
    end

### Test a file with an ini-like structure (such as a yum.conf)

    describe parse_config_file('/path/to/yum.conf') do
     its('main') { should include('gpgcheck' => '1') }
    end

## Matchers

For a full list of available matchers, please visit our [matchers page](/inspec/matchers/).

### assignment_regex

Use `assignment_regex` to test a key value using a regular expression:

    'key = value'

may be tested using the following regular expression, which determines assignment from key to value:

    assignment_regex: /^\s*([^=]*?)\s*=\s*(.*?)\s*$/

### comment_char

Use `comment_char` to test for comments in a configuration file:

    comment_char: '#'

### key_values

Use `key_values` to test how many values a key contains:

    key = a b c

contains three values. To test that value to ensure it only contains one, use:

    key_values: 1

### multiple_values

Use `multiple_values` if the source file uses the same key multiple times. All values will be aggregated in an array:

    # # file structure:
    # key = a
    # key = b
    # key2 = c
    params['key'] = ['a', 'b']
    params['key2'] = ['c']

To use plain key value mapping, use `multiple_values: false`:

    # # file structure:
    # key = a
    # key = b
    # key2 = c
    params['key'] = 'b'
    params['key2'] = 'c'

### standalone_comments

Use `standalone_comments` to parse comments as a line, otherwise inline comments are allowed:

    'key = value # comment'
    params['key'] = 'value # comment'

Use `standalone_comments: false`, to parse the following:

    'key = value # comment'
    params['key'] = 'value'
