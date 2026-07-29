+++
title = "Set up knife"
draft = false

[menu]
  [menu.workstation_26_0]
    title = "Set up knife"
    identifier = "workstation_26_0/tools/knife/knife_setup.md Setting up knife"
    parent = "workstation_26_0/tools/knife"
    weight = 20
+++
<!-- markdownlint-disable-file MD036 -->

knife is a command-line tool that provides an interface between a local chef-repo and Chef Infra Server. knife must be configured to communicate with Chef Infra Server and any other infrastructure in your organization.

You can configure knife using one of two methods:

- **Credentials file** (`.chef/credentials`): The recommended approach. Supports multiple named profiles, making it easy to switch between Chef Infra Servers or organizations. Uses TOML format.
- **`config.rb`**: A legacy approach that's still valid for simpler setups. Supports a single Chef Infra Server and organization. Uses Ruby format, which allows dynamic configuration using environment variables and Ruby expressions.

You can't use both methods at the same time.

## Credentials file

Add knife profiles to the `.chef/credentials` file in your home directory. The `credentials` file is TOML formatted. Each profile is a separate table with a name of your choice, followed by `key = value` pairs. The keys correspond to any setting permitted in the [config.rb](/workstation/26.0/tools/knife/config_rb/) file.

File paths, such as `client_key` or `validator_key`, are relative to `~/.chef` unless you provide an absolute path. Identify clients with `client_name` (preferred) or `node_name`.

To store credentials for target mode (`chef-client --target switch.example.org`), add them as a separate profile using the DNS name of the target as the profile name. Enclose the profile name in single quotes if it contains a period, for example `['switch.example.org']`. Valid configuration keys are passed to train, such as `port`.

```toml
# Example .chef/credentials file
[default]
client_name = "barney"
client_key = "barney_rubble.pem"
chef_server_url = "https://api.example.com/organizations/bedrock"

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
chef_server_url = "https://api.example.com/organizations/test"

['web.preprod']
client_name = "brubble"
client_key = "preprod-brubble.pem"
chef_server_url = "https://preprod.example.com/organizations/preprod"

['switch.example.org']
user = "cisco"
password = "cisco"
enable_password = "cisco"
```

There are four ways to select which profile to use, listed in priority order:

1. Pass the `--profile` option to knife, for example `knife node list --profile dev`.
1. Set the profile name in the `CHEF_PROFILE` environment variable.
1. Write the profile name to the `~/.chef/context` file.
1. Otherwise, knife uses the `default` profile.

### Configure credentials file

To configure knife to communicate with Chef Infra Server for the first time, run `knife configure` to create a credentials file at `~/.chef/credentials`.

Use the `knife config` command to manage your knife profiles.

List your profiles with the `knife config list-profiles` command.

For example:

```bash
knife config list-profiles
```

Returns something like:

```bash
## Profile              Client   Key                          Server
 default             barney   ~/.chef/barney_rubble.pem    https://api.example.com/organizations/bedrock
 dev                 admin    ~/.chef/admin.pem            https://api.example.com/organizations/test
 web.preprod         brubble  ~/.chef/preprod-brubble.pem  https://preprod.example.com/organizations/preprod
 switch.example.org  btm      ~/.chef/btm.pem              https://localhost:443
```

The line that begins with the asterisk is the currently selected profile. To change the current profile, run `knife config use-profile NAME`, which writes the profile name to the `~/.chef/context` file.

Run `knife config get-profile` to print the name of the currently selected profile.

To troubleshoot settings, verify the value knife is using with `knife config get KEY`, for example:

```bash
knife config get chef_server_url
Loading from credentials file /home/barney/.chef/credentials
chef_server_url: https://api.example.com/organizations/test
```

## config.rb configuration file

The `config.rb` file contains settings for the knife command-line tool and any installed knife plugins.

### Create the config.rb file

To create the `.chef` directory and an empty `config.rb` file, run the following commands:

On macOS and Linux:

```bash
mkdir ~/.chef
touch ~/.chef/config.rb
```

On Windows:

```powershell
New-Item -Path "c:\" -Name ".chef" -ItemType "directory"
New-Item -ItemType "file" -Path "c:\.chef\config.rb"
```

For a complete list of configuration options, see the [config.rb documentation](/workstation/26.0/tools/knife/config_rb/).

### Load path priority

The `config.rb` file loads every time the knife command is invoked using the following load order:

- From a specified location given the `--config` flag
- From a specified location given the `$KNIFE_HOME` environment variable, if set
- From a `config.rb` file within the current working directory, for example, `./config.rb`
- From a `config.rb` file within a `.chef` directory in the current working directory, for example, `./.chef/config.rb`
- From a `config.rb` file within a `.chef` directory located one directory above the current working directory, for example, `../.chef/config.rb`
- From `~/.chef/config.rb` on macOS or Linux, or `c:\Users\<USERNAME>\.chef` on Windows

{{< note >}}

On Windows, the `config.rb` file is located at: `%HOMEDRIVE%:%HOMEPATH%\.chef` (e.g. `c:\Users\<USERNAME>\.chef`).
In a script for Windows, use: `%USERPROFILE%\chef-repo\.chef`.

{{< /note >}}

### Extend config.rb with Ruby code

You can include arbitrary Ruby code in `config.rb` to extend configuration beyond static values, such as loading environment variables from the workstation.
This makes it possible to write a single `config.rb` for all users in your organization.
You can also check this file into your chef-repo, so users can load different `config.rb` files depending on which chef-repo they're working in---useful when each chef-repo points to a different Chef Infra Server or organization.

Example `config.rb`:

```ruby
current_dir = File.dirname(__FILE__)
  user = ENV['CHEF_USER'] || ENV['USER']
  node_name                user
  client_key               "#{ENV['HOME']}/chef-repo/.chef/#{user}.pem"
  chef_server_url          "https://api.opscode.com/organizations/#{ENV['ORGNAME']}"
  syntax_check_cache_path  "#{ENV['HOME']}/chef-repo/.chef/syntax_check_cache"
  cookbook_path            ["#{current_dir}/../cookbooks"]
  cookbook_copyright       "Example Organization, Inc."
  cookbook_license         "Apache-2.0"
  cookbook_email           "cookbooks@example.com"

  # Amazon AWS
  knife[:aws_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
  knife[:aws_secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']
```

### Set a text editor

Some knife commands (such as `knife data bag edit`) open information as JSON data in a text editor for editing. Configure the editor using either the `EDITOR` environment variable or an entry in your `config.rb` file. For example, to use `vim`:

```ruby
knife[:editor] = "/usr/bin/vim"
```

#### Windows paths

Because `config.rb` is a Ruby file, Windows file paths inside double-quoted strings require special handling:

- **Backslashes must be escaped**: the backslash (`\`) is both the Windows path separator and the Ruby escape character, so each backslash must be doubled (`\\`).
- **Spaces must use 8.3 short names**: replace spaces in directory names with the 8.3 short name equivalent (for example, `Program Files` becomes `Progra~1`) so that no path segment exceeds 8 characters.

For example, if EditPad Pro is installed at:

```powershell
C:\Program Files (x86)\EditPad Pro\EditPad.exe
```

The `config.rb` entry would be:

```ruby
knife[:editor] = "C:\\Progra~1\\EditPa~1\\EditPad.exe"
```

To avoid escaping backslashes, wrap the double-quoted Windows path in single quotes:

Notepad++:

```ruby
knife[:editor] = '"C:\Program Files (x86)\Notepad++\notepad++.exe" -nosession -multiInst'
```

Sublime Text:

```ruby
knife[:editor] = '"C:\Program Files\Sublime Text 2\sublime_text.exe" --wait'
```

TextPad:

```ruby
knife[:editor] = '"C:\Program Files (x86)\TextPad 7\TextPad.exe"'
```

vim:

```ruby
knife[:editor] = '"C:\Program Files (x86)\vim\vim74\gvim.exe"'
```

{{< note >}}

The text editor command can't include unquoted spaces. Use either double quotes (`" "`) or single quotes (`' '`) consistently, as shown in the examples above.

{{< /note >}}
