+++
title = "Set up Knife"
draft = false

[menu]
  [menu.workstation_25]
    title = "Set up Knife"
    identifier = "workstation_25/tools/knife/set_up.md Setting up Knife"
    parent = "workstation_25/tools/knife"
    weight = 20
+++
<!-- markdownlint-disable-file MD036 -->

knife is a command-line tool that provides an interface between a local chef-repo and Chef Infra Server. The knife command line tool must be configured to communicate with Chef Infra Server as well as any other infrastructure within your organization.

To configure knife to communicate with Chef Infra Server for the first time run `knife configure` to create a Chef Infra credentials file at `~/.chef/credentials`.

## config.rb

Previous Chef Infra setups recommended setting up knife with a `config.rb` file. Configuring knife with `config.rb` is still valid, but only for working with a single Chef Infra Server with a single Chef Infra Server organization.

```bash
mkdir ~/.chef
touch ~/.chef/config.rb
```

```powershell
New-Item -Path "c:\" -Name ".chef" -ItemType "directory"
New-Item -ItemType "file" -Path "c:\.chef\config.rb"
```

The config.rb configuration can include arbitrary Ruby code to extend
configuration beyond static values. This can be used to load
environmental variables from the workstation. This makes it possible to
write a single `config.rb` file that can be used by all users within your
organization. This single file can also be checked into your chef-repo,
allowing users to load different `config.rb` files based on which
chef-repo they execute the commands from. This can be especially useful
when each chef-repo points to a different Chef Infra Server or organization.

Example config.rb:

```ruby
current_dir = File.dirname(__FILE__)
  user = ENV['CHEF_USER'] || ENV['USER']
  node_name                user
  client_key               "#{ENV['HOME']}/chef-repo/.chef/#{user}.pem"
  chef_server_url          "https://api.opscode.com/organizations/#{ENV['ORGNAME']}"
  syntax_check_cache_path  "#{ENV['HOME']}/chef-repo/.chef/syntax_check_cache"
  cookbook_path            ["#{current_dir}/../cookbooks"]
  cookbook_copyright       "Your Company, Inc."
  cookbook_license         "Apache-2.0"
  cookbook_email           "cookbooks@yourcompany.com"

  # Amazon AWS
  knife[:aws_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
  knife[:aws_secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']
```

## Knife profiles

Knife profiles make switching knife between Chef Infra Servers or between organizations on the same Chef Infra Server easier. Knife profiles are an alternative to `config.rb`--you can't use both.

Set up knife profiles by adding them to the `.chef/credentials` file in your home directory on your workstation. The `credentials` file is TOML formatted. Each profile is listed as a separate 'table' name of your choice, and is followed by `key = value` pairs. The keys correspond to any setting permitted in the [config.rb](/workstation/25/tools/knife/config_rb/) file.

File paths, such as `client_key` or `validator_key`, are relative to `~/.chef` unless you provide absolute path. Identify clients with `client_name` (preferred) or `node_name`.

Store credentials for use with target mode (`chef-client --target switch.example.org`) as a separate profile in the credentials file. Use the DNS name of the target as the profile name and surrounded by single
quotes when the name contains a period. For example:
`['switch.example.org']`. Keys that are valid configuration options get passed to train, such as `port`.

```text
# Example .chef/credentials file
[default]
client_name = "barney"
client_key = "barney_rubble.pem"
chef_server_url = "https://api.chef.io/organizations/bedrock"

# a 'config context' such as knife can be is configured as a separate table
[default.knife]
ssh_user = 'ubuntu' # this would have been knife[:ssh_user] in your config.rb
aws_profile = 'engineering'
use_sudo = true

# a client_key may also be specified inline as in this example
[dev]
client_name = "admin"
client_key = """
-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCqGKukO1De7zhZj6EXAMPLEKEY
...ABC123=
-----END RSA PRIVATE KEY-----
"""
validator_key = "test-validator.pem"
chef_server_url = "https://api.chef-server.dev/organizations/test"

['web.preprod']
client_name = "brubble"
client_key = "preprod-brubble.pem"
chef_server_url = "https://preprod.chef-server.dev/organizations/preprod"

['switch.example.org']
user = "cisco"
password = "cisco"
enable_password = "cisco"
```

There are four ways to select which profile to use and are listed in
priority order:

1. Pass the `--profile` option to knife, e.g. `knife node list --profile dev`.
2. Set the profile name in the `CHEF_PROFILE` environment variable.
3. Write the profile name to the `~/.chef/context` file.
4. Otherwise, knife uses the 'default' profile.

## Knife Config

Use the `knife config` command to manage your knife profiles.

List your profiles with the `knife config list-profiles` command.

For example:

```bash
knife config list-profiles
```

Returns something like:

```bash
## Profile              Client   Key                          Server
 default             barney   ~/.chef/barney_rubble.pem    https://api.chef.io/organizations/bedrock
 dev                 admin    ~/.chef/admin.pem            https://api.chef-server.dev/organizations/test
 web.preprod         brubble  ~/.chef/preprod-brubble.pem  https://preprod.chef-server.dev/organizations/preprod
 switch.example.org  btm      ~/.chef/btm.pem              https://localhost:443
```

The line that begins with the asterisk is the currently selected profile. To change the current profile, run the `knife config use-profile NAME` command, which will write the profile name to the `~/.chef/context` file.

Running `knife config get-profile` prints out the name of the currently selected profile.

If you need to troubleshoot any settings, you can verify the value that knife is using with the `knife config get KEY` command, for example:

```bash
knife config get chef_server_url
Loading from credentials file /home/barney/.chef/credentials
chef_server_url: https://api.chef-server.dev/organizations/test
```

## config.rb configuration file

The `config.rb`  file contains settings for the knife command-line tool and any
installed knife plugins.
See the [config.rb documentation](/workstation/25/tools/knife/config_rb/) for a complete list of configuration options.

### Load path priority

The `config.rb` file loads every time the knife command is invoked using the following load order:

- From a specified location given the `--config` flag
- From a specified location given the `$KNIFE_HOME` environment variable, if set
- From a `config.rb` file within the current working directory, for example, `./config.rb`
- From a `config.rb` file within a `.chef` directory in the current working directory, for example, `./.chef/config.rb`
- From a `config.rb` file within a `.chef` directory located one directory above the current working directory, for example, `../.chef/config.rb`
- From `~/.chef/config.rb` (macOS and Linux platforms) or `c:\Users\<username>\.chef` (Windows platform)

{{< note >}}

On Windows, the `config.rb` file is located at: `%HOMEDRIVE%:%HOMEPATH%\.chef` (e.g. `c:\Users\<username>\.chef`).
In a script for Windows, use: `%USERPROFILE%\chef-repo\.chef`.

{{< /note >}}

### config.rb Configuration Within a Chef Repository

Use `knife configure` command to generate your initial `config.rb` file in your home directory.
See [knife configure](/workstation/25/tools/knife/knife_configure/) for details.

## Setting Your Text Editor

Some knife commands, such as `knife data bag edit`, require that information be edited as JSON data using a text editor. For example, the following command:

```bash
knife data bag edit admins admin_name
```

opens up the text editor with data similar to:

```javascript
{
  "id": "admin_name"
}
```

Then make changes to that file:

```javascript
{
  "id": "Justin C."
  "description": "I am passing the time by letting time pass over me ..."
}
```

The type of text editor that's used by knife can be configured by adding an entry to your `config.rb` file, or by setting an `EDITOR` environment variable. For example, to configure knife to open the `vim` text editor, add the following to your `config.rb` file:

```ruby
knife[:editor] = "/usr/bin/vim"
```

When a Windows file path is enclosed in a double-quoted string (" "), the same backslash character (`\`) that's used to define the file path separator is also used in Ruby to define an escape character. The `config.rb` file is a Ruby file; therefore, file path separators must be escaped. In addition, spaces in the file path must be replaced with `~1` so that the length of each section within the file path isn't more than 8 characters. For example, if EditPad Pro is the text editor of choice and is located at the following path:

```powershell
C:\\Program Files (x86)\EditPad Pro\EditPad.exe
```

the setting in the `config.rb` file would be similar to:

```ruby
knife[:editor] = "C:\\Progra~1\\EditPa~1\\EditPad.exe"
```

One approach to working around the double- vs. single-quote issue is to
put the single-quotes outside of the double-quotes. For example, for
Notepad++:

```ruby
knife[:editor] = '"C:\Program Files (x86)\Notepad++\notepad++.exe" -nosession -multiInst'
```

for Sublime Text:

```ruby
knife[:editor] = '"C:\Program Files\Sublime Text 2\sublime_text.exe" --wait'
```

for TextPad:

```ruby
knife[:editor] = '"C:\Program Files (x86)\TextPad 7\TextPad.exe"'
```

and for vim:

```ruby
knife[:editor] = '"C:\Program Files (x86)\vim\vim74\gvim.exe"'
```

### Using Quotes

 The text editor command can't include spaces that aren't properly wrapped in quotes. The command can be entered with double quotes (" ") or single quotes (' '), but this should be done consistently as shown in the examples above.
