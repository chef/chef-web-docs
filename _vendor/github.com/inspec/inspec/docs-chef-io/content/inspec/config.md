+++
title = "InSpec Configuration File"
draft = false

[menu]
  [menu.inspec]
    title = "Configuration"
    identifier = "inspec/reference/config.md Configuration"
    parent = "inspec/reference"
    weight = 60
+++

[\[edit on GitHub\]](https://github.com/inspec/inspec/blob/master/docs-chef-io/content/inspec/config.md)

This documents the Chef InSpec configuration file format introduced in version 3.5 of InSpec and extended in later versions.

## Config File Location

By default, Chef InSpec looks for a config file in `~/.inspec/config.json`.  Chef InSpec does not need a configuration file to run.

You may also specify the location using `--config`.  For example, to run the shell using a config file in `/etc/inspec`, use `inspec shell --config /etc/inspec/config.json`.

## Config File Format Versions

Config files must contain a top-level key, `version`, which indicates the file format. This allows us to add new fields without breaking old installations.

## Version 1.1

### Complete Example

```
{
  "version": "1.1",
  "cli_options":{
    "color": "true"
  },
  "credentials": {
    "ssh": {
      "my-target": {
        "host":"somewhere.there.com",
        "user":"bob"
      }
    }
  },
  "reporter": {
    "automate" : {
      "stdout" : false,
      "url" : "https://YOUR_A2_URL/data-collector/v0/",
      "token" : "YOUR_A2_API_TOKEN",
      "insecure" : true,
      "node_name" : "inspec_test_node",
      "environment" : "prod"
    }
  }
}
```

version
: Should have the value '1.1'.

cli_options
: Any long-form command line option, without the leading dashes.

credentials
: Train-transport-specific options. Store the options keyed first by transport name, then by a name you'll use later on. The combination of transport name and your chosen name can be used in the `--target` option to `inspec exec`, as `--target transport-name://connection-name`.

For example, if the config file contains:

```
{
  "credentials": {
    "winrm": {
      "myconn": {
        "user": "Administrator",
        "host": "prod01.east.example.com",
        "disable_sspi": true,
        "connection_retries": 10
      }
    }
  }
}
```

Then use `-t winrm://myconn` to connect to the host, with the given extra options.

Each Train transport offers a variety of options. By using the credential set facility, you are able to easily set options that are not accessible via the Train URI.

You may have as many credential sets in the config file as you require.

If you use a target URI and the portion after the `://` cannot be matched to credential set name, Chef InSpec will send the URI to Train to be parsed as a Train URI.  Thus, you can still do `ssh://someuser@myhost.com`.

You can use a credential set, and then override individual options using command line options.

Credential sets are intended to work hand-in-hand with the underlying credentials storage facility of the transport. For example, if you have a `~/.ssh/config` file specifying that the sally-key.pem file should be used with the host `somehost.com`, and you have a credential set that specifies that host, then when Train tries to connect to that host, the SSH library will automatically use the SSH config file to use the indicated key.

### reporter

You may also set output (reporter) options in the config file.  See the [Reporters Page](/inspec/reporters/) for details.

## Version 1.2

Version 1.2 adds a top-level field, "plugins".

### plugins

Use the `plugins` top-level configuration field to provide configuration settings to plugins that you use with Chef InSpec. Refer to the documentation of the plugin you are using for details regarding what settings are available.

To use this new feature, add a new top-level key in your config file named  `plugins`. Then create a sub-key named for each plugin you wish to configure. Each plugin will have a key-value are that it may use as it sees fit - Chef Inspec does not specify the structure. Here is an example, using contrived plugins:

```
{
  "version":"1.2",
  "plugins": {
    "inspec-training-wheels": {
      "diameter": "4 inches"
    },
    "inspec-input-secrets": {
      "security-tokens: [
        "123456789".
        "abcdef252875"
      ]
    }
  }
}
```
