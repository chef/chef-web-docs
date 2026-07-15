+++
title = "knife exec"
draft = false



[menu]
  [menu.workstation_26_0]
    title = "knife exec"
    identifier = "workstation_26_0/tools/knife/reference/knife_exec.md knife exec"
    parent = "workstation_26_0/tools/knife/reference"
+++
<!-- markdownlint-disable-file MD033 MD036 -->

{{< readfile file="content/workstation/26.0/reusable/md/knife_exec_summary.md" >}}

## Authenticated API requests

The `knife exec` subcommand can be used to make authenticated API
requests to Chef Infra Server using the following methods:

`api.delete`
: Use to delete an object from Chef Infra Server.

`api.get`
: Use to get the details of an object on Chef Infra Server.

`api.post`
: Use to add an object to Chef Infra Server.

`api.put`
: Use to update an object on Chef Infra Server.

These methods are used with the `-E` option, which executes that string
locally on the workstation using chef-shell. These methods have the
following syntax:

```bash
knife exec -E 'api.method(/endpoint)'
```

where:

- `api.method` is the corresponding authentication method --- `api.delete`, `api.get`, `api.post`, or `api.put`
- `/endpoint` is an endpoint in the Chef Infra Server API

For example, to get the data for a node named "Example_Node":

```bash
knife exec -E 'puts api.get("/nodes/Example_Node")'
```

and to ensure that the output is visible in the console, add the `puts`
in front of the API authorization request:

```bash
knife exec -E 'puts api.get("/nodes/Example_Node")'
```

where `puts` is the shorter version of the `$stdout.puts` predefined
variable in Ruby.

The following example shows how to add a client named `EXAMPLE_CLIENT` and
the `/clients` endpoint, and then return the private key for that user
in the console:

```bash
client_desc = {
    "name"  => "EXAMPLE_CLIENT",
    "admin" => false
  }

  new_client = api.post("/clients", client_desc)
  puts new_client["private_key"]
```

## Ruby Scripts

For Ruby scripts that will be run using the `exec` subcommand, note the
following:

- The Ruby script must be located on the system from which knife is run (and not be located on any of the systems that knife will be managing).
- Shell commands will be run from a management workstation. For example, something like `%x[ls -lash /opt/only-on-a-node]` would give you the directory listing for the "opt/only-on-a-node" directory or a "No such file or directory" error if the file doesn't already exist locally.
- When the chef-shell DSL is available, the Chef Infra Client DSL won't be (unless the management workstation is also a Chef Infra Client). Without the Chef Infra Client DSL, a bash block can't be used to run bash commands.

## Syntax

This subcommand has the following syntax:

```bash
knife exec SCRIPT (options)
```

## Options

{{< note >}}

{{< readfile file="content/workstation/26.0/reusable/md/knife_common_see_common_options_link.md" >}}

{{< /note >}}

This subcommand has the following options:

`-E CODE`, `--exec CODE`

: A string of code to be executed.

`-p PATH:PATH`, `--script-path PATH:PATH`

: A colon-separated path at which Ruby scripts are located. Use to override the default location for scripts. When this option isn't specified, knife will look for scripts located in `chef-repo/.chef/scripts` directory.

{{< note >}}

{{< readfile file="content/workstation/26.0/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

## Examples

The following examples show how to use this knife subcommand:

**Run Ruby scripts**

There are three ways to use `knife exec` to run Ruby script files. For
example:

```bash
knife exec /path/to/script_file
```

or:

```bash
knife exec -E 'RUBY CODE'
```

or:

```bash
knife exec
RUBY CODE
^D
```

**Chef knife status**

To check the status of knife using a Ruby script named `status.rb`
(which looks like):

```ruby
printf "%-5s %-12s %-8s %s\n", "Check In", "Name", "Ruby", "Recipes"
nodes.all do |n|
   checkin = Time.at(n['ohai_time']).strftime("%F %R")
   rubyver = n['languages']['ruby']['version']
   recipes = n.run_list.expand(_default).recipes.join(", ")
   printf "%-20s %-12s %-8s %s\n", checkin, n.name, rubyver, recipes
end
```

and is located in a directory named `scripts/`, enter:

```bash
knife exec scripts/status.rb
```

**List available free memory**

To show the available free memory for all nodes, enter:

```bash
knife exec -E 'nodes.all {|n| puts "#{n.name} has #{n.memory.total} free memory"}'
```

**List available search indexes**

To list the available search indexes, enter:

```bash
knife exec -E 'puts api.get("search").keys'
```

**Operations on Users and User Keys**

To change any global end points like user or user keys, use the `--server-url` flag:

```bash
knife exec -E 'api.delete("/users/myuser/keys/user33")' --server-url https://
```

**Query for multiple attributes**

To query a node for multiple attributes using a Ruby script named
`search_attributes.rb` (which looks like):

```ruby
% cat scripts/search_attributes.rb
query = ARGV[2]
attributes = ARGV[3].split(",")
puts "Your query: #{query}"
puts "Your attributes: #{attributes.join(" ")}"
results = {}
search(:node, query) do |n|
   results[n.name] = {}
   attributes.each {|a| results[n.name][a] = n[a]}
end

puts results
exit 0
```

enter:

```bash
% knife exec scripts/search_attributes.rb "hostname:test_system" ipaddress,fqdn
```

to return something like:

```bash
Your query: hostname:test_system
Your attributes: ipaddress fqdn
{"test_system.example.com"=>{"ipaddress"=>"10.1.1.200", "fqdn"=>"test_system.example.com"}}
```

**Find shadow cookbooks**

To find the locations in which cookbooks exist that may shadow
each other, create a file called `shadow-check.rb` that contains the
following Ruby code:

```ruby
config = Chef::Config

cookbook_loader = begin
  Chef::Cookbook::FileVendor.on_create { |manifest| Chef::Cookbook::FileSystemFileVendor.new(manifest, config[:cookbook_path]) }
  Chef::CookbookLoader.new(config[:cookbook_path])
end

ui = Chef::Knife::UI.new($stdout, $stderr, $stdin, {})

cookbook_loader.load_cookbooks

if cookbook_loader.merged_cookbooks.empty?
  ui.msg "cookbooks ok"
else
  ui.warn "* " * 40
  ui.warn(<<-WARNING)
The cookbooks: #{cookbook_loader.merged_cookbooks.join(', ')} exist in multiple places in your cookbook_path.
A composite version of these cookbooks has been compiled for uploading.

#{ui.color('IMPORTANT:', :red, :bold)} In a future version of Chef, this behavior will be removed and you will no longer
be able to have the same version of a cookbook in multiple places in your cookbook_path.
WARNING
  ui.warn "The affected cookbooks are located:"
  ui.output ui.format_for_display(cookbook_loader.merged_cookbook_paths)
  ui.warn "* " * 40
end
```

Put this file in the directory of your choice. Run the following
command:

```bash
knife exec shadow-check.rb
```

and be sure to edit `shadow-check.rb` so that it defines the path to
that file correctly.
