+++
title = "knife search"
draft = false



[menu]
  [menu.workstation_26_0]
    title = "knife search"
    identifier = "workstation_26_0/tools/knife/reference/knife_search.md knife search"
    parent = "workstation_26_0/tools/knife/reference"
+++
<!-- markdownlint-disable-file MD024 MD036 -->

Search indexes allow queries to be made for any type of data that's
indexed by the Chef Infra Server, including data bags (and data bag
items), environments, nodes, and roles. A defined query syntax is used
to support search patterns like exact, wildcard, range, and fuzzy. A
search is a full-text query that can be done from several locations,
including from within a recipe, by using the `search` subcommand in
knife, the `search` method in the Chef Infra Language, the search box in the Chef
management console, and by using the `/search` or `/search/INDEX`
endpoints in the Chef Infra Server API. The search engine is based on
Elasticsearch and is run from the Chef Infra Server.

{{< readfile file="content/workstation/26.0/reusable/md/knife_search_summary.md" >}}

## Syntax

This subcommand has the following syntax:

```bash
knife search INDEX SEARCH_QUERY
```

where `INDEX` is one of `client`, `environment`, `node`, `role`, or the
name of a data bag and `SEARCH_QUERY` is the search query syntax for the
query that will be executed.

`INDEX` is implied if omitted, and will default to `node`. For example:

```bash
knife search '*:*' -i
```

will return something similar to:

```bash
8 items found

centos-62-dev
opensuse-15
ubuntu-1804-orgtest
ubuntu-1804-ohai-test
ubuntu-1804-ifcfg-test
ohai-test
win2k19-dev
```

and is the same search as:

```bash
knife search node '*:*' -i
```

If the `SEARCH_QUERY` doesn't contain a colon character (`:`), then the
default query pattern is
`tags:*#{@query}* OR roles:*#{@query}* OR fqdn:*#{@query}* OR addresses:*#{@query}*`,
which means the following two search queries are effectively the same:

```bash
knife search ubuntu
```

or:

```bash
knife search node "tags:*ubuntu* OR roles:*ubuntu* OR fqdn:*ubuntu* (etc.)"
```

### Query Syntax

A search query is comprised of two parts: the key and the search
pattern. A search query has the following syntax:

```ruby
key:search_pattern
```

where `key` is a field name that's found in the JSON description of an
indexable object on the Chef Infra Server (a role, node, client,
environment, or data bag) and `search_pattern` defines what will be
searched for, using one of the following search patterns: exact,
wildcard, range, or fuzzy matching. Both `key` and `search_pattern` are
case-sensitive; `key` has limited support for multiple character
wildcard matching using an asterisk ("\*") (and as long as it's not the
first character).

### Keys

A field name/description pair is available in the JSON object. Use the
field name when searching for this information in the JSON object. Any
field that exists in any JSON description for any role, node, Chef Infra
Client, environment, or data bag can be searched.

To search for the available fields for a particular object, use the
`show` argument with any of the following knife subcommands:
`knife client`, `knife data bag`, `knife environment`, `knife node`, or
`knife role`. For example: `knife data bag show`.

#### Nested Fields

A nested field appears deeper in the JSON data structure. For example,
information about a network interface might be several layers deep:
`node['network']['interfaces']['en1']`. When nested fields are present
in a JSON structure, Chef Infra Client will extract those nested fields
to the top-level, flattening them into compound fields that support
wildcard search patterns.

By combining wildcards with range-matching patterns and wildcard
queries, it's possible to perform powerful searches, such as using
the vendor part of the MAC address to find every node that has a network
card made by the specified vendor.

Consider the following snippet of JSON data:

```json
{"network":
  [
  //snipped...
    "interfaces",
      {"en1": {
        "number": "1",
        "flags": [
          "UP",
          "BROADCAST",
          "SMART",
          "RUNNING",
          "SIMPLEX",
          "MULTICAST"
        ],
        "addresses": {
          "fe80::fa1e:dfff:fed8:63a2": {
            "scope": "Link",
            "prefixlen": "64",
            "family": "inet6"
          },
          "f8:1e:df:d8:63:a2": {
            "family": "lladdr"
          },
          "192.0.2.0": {
            "netmask": "255.255.255.0",
            "broadcast": "192.168.0.255",
            "family": "inet"
          }
        },
        "mtu": "1500",
        "media": {
          "supported": {
            "autoselect": {
              "options": [

              ]
            }
          },
          "selected": {
            "autoselect": {
              "options": [

              ]
            }
          }
        },
        "type": "en",
        "status": "active",
        "encapsulation": "Ethernet"
      },
  //snipped...
```

Before this data is indexed on the Chef Infra Server, the nested fields
are extracted into the top level, similar to:

```ruby
"broadcast" => "192.168.0.255",
"flags"     => ["UP", "BROADCAST", "SMART", "RUNNING", "SIMPLEX", "MULTICAST"]
"mtu"       => "1500"
```

which allows searches like the following to find data that's present in
this node:

```ruby
node "broadcast:192.168.0.*"
```

or:

```ruby
node "mtu:1500"
```

or:

```ruby
node "flags:UP"
```

This data is also flattened into various compound fields, which follow
the same pattern as the JSON hierarchy and use underscores (`_`) to
separate the levels of data, similar to:

```ruby
# ...snip...
"network_interfaces_en1_addresses_192.0.2.0_broadcast" => "192.168.0.255",
"network_interfaces_en1_addresses_fe80::fa1e:tldr_family"  => "inet6",
"network_interfaces_en1_addresses"                         => ["fe80::fa1e:tldr","f8:1e:df:tldr","192.0.2.0"]
# ...snip...
```

which allows searches like the following to find data that's present in
this node:

```ruby
node "network_interfaces_en1_addresses:192.0.2.0"
```

This flattened data structure also supports using wildcard compound
fields, which allow searches to omit levels within the JSON data
structure that aren't important to the search query. In the following
example, an asterisk (`*`) is used to show where the wildcard can exist
when searching for a nested field:

```ruby
"network_interfaces_*_flags"     => ["UP", "BROADCAST", "SMART", "RUNNING", "SIMPLEX", "MULTICAST"]
"network_interfaces_*_addresses" => ["fe80::fa1e:dfff:fed8:63a2", "192.0.2.0", "f8:1e:df:d8:63:a2"]
"network_interfaces_en0_media_*" => ["autoselect", "none", "1000baseT", "10baseT/UTP", "100baseTX"]
"network_interfaces_en1_*"       => ["1", "UP", "BROADCAST", "SMART", "RUNNING", "SIMPLEX", "MULTICAST",
                                     "fe80::fa1e:dfff:fed8:63a2", "f8:1e:df:d8:63:a2", "192.0.2.0",
                                     "1500", "supported", "selected", "en", "active", "Ethernet"]
```

For each of the wildcard examples above, the possible values are shown
contained within the brackets. When running a search query, the query
syntax for wildcards is to simply omit the name of the node (while
preserving the underscores), similar to:

```ruby
network_interfaces__flags
```

This query will search within the `flags` node, within the JSON
structure, for each of `UP`, `BROADCAST`, `SMART`, `RUNNING`, `SIMPLEX`,
and `MULTICAST`.

#### Examples

To see the available keys for a node, enter the following (for a node
named `staging`):

```bash
knife node show staging -Fj | less
```

to return a full JSON description of the node and to view the available
keys with which any search query can be based.

To use a question mark (`?`) to replace a single character in a wildcard
search, enter the following:

```bash
knife search node 'platfor?:ubuntu'
```

To use an asterisk (`*`) to replace zero (or more) characters in a
wildcard search, enter the following:

```bash
knife search node 'platfo*:ubuntu'
```

To find all IP address that are on the same network, enter the
following:

```bash
knife search node 'ipaddress:192.168*'
```

where `192.168*` is the network address for which the search will be
run.

To use a range search to find IP addresses within a subnet, enter the
following:

```bash
knife search node 'ipaddress:[192.168.0.* TO 192.0.2.*]'
```

where `192.168.0.* TO 192.0.2.*` defines the subnet range.

### About Patterns

A search pattern is a way to fine-tune search results by returning
anything that matches some type of incomplete search query. There are
four types of search patterns that can be used when searching the search
indexes on the Chef Infra Server: exact, wildcard, range, and fuzzy.

#### Exact Matching

An exact matching search pattern is used to search for a key with a name
that exactly matches a search query. If the name of the key contains
spaces, quotes must be used in the search pattern to ensure the search
query finds the key. The entire query must also be contained within
quotes, so as to prevent it from being interpreted by Ruby or a command
shell. The best way to ensure that quotes are used consistently is to
quote the entire query using single quotes (' ') and a search pattern
with double quotes (" ").

To search in a specific data bag for a specific data bag item, enter the
following:

```bash
knife search admins 'id:charlie'
```

where `admins` is the name of the data bag and `charlie` is the name of
the data bag item. Something similar to the following will be returned:

```bash
1 items found
_rev:       1-39ff4099f2510f477b4c26bef81f75b9
chef_type:  data_bag_item
comment:    Charlie the Unicorn
data_bag:   admins
gid:        ops
id:         charlie
shell:      /bin/zsh
uid:        1005
```

To search in a specific data bag using a string to find any matching
data bag item, enter the following:

```bash
knife search admins 'comment:"Charlie the Unicorn"'
```

where `admins` is the name of the data bag and `Charlie the Unicorn` is
the string that will be used during the search. Something similar to the
following will be returned:

```bash
1 items found
_rev:       1-39ff4099f2510f477b4c26bef81f75b9
chef_type:  data_bag_item
comment:    Charlie the Unicorn
data_bag:   admins
gid:        ops
id:         charlie
shell:      /bin/zsh
uid:        1005
```

#### Wildcard Matching

A wildcard matching search pattern is used to query for substring
matches that replace zero (or more) characters in the search pattern
with anything that could match the replaced character. There are two
types of wildcard searches:

- A question mark (`?`) can be used to replace exactly one character
    (as long as that character isn't the first character in the search
    pattern)
- An asterisk (`*`) can be used to replace any number of characters (including zero)

To search for any node that contains the specified key, enter the
following:

```bash
knife search node 'foo:*'
```

where `foo` is the name of the node.

To search for a node using a partial name, enter one of the following:

```bash
knife search node 'name:app*'
```

or:

```bash
knife search node 'name:app1*.example.com'
```

or:

```bash
knife search node 'name:app?.example.com'
```

or:

```bash
knife search node 'name:app1.example.???'
```

to return `app1.example.com` (and any other node that matches any of the
string searches above).

#### Range Matching

A range matching search pattern is used to query for values that are
within a range defined by upper and lower boundaries. A range matching
search pattern can be inclusive or exclusive of the boundaries. Use
square brackets ("\[ \]") to denote inclusive boundaries and curly
braces ("{ }") to denote exclusive boundaries and with the following
syntax:

```ruby
boundary TO boundary
```

where `TO` is required (and must be capitalized).

A data bag named `sample` contains four data bag items: `abc`, `bar`,
`baz`, and `quz`. All of the items in-between `bar` and `foo`,
inclusive, can be searched for using an inclusive search pattern.

To search using an inclusive range, enter the following:

```bash
knife search sample "id:[bar TO foo]"
```

where square brackets (`[ ]`) are used to define the range.

A data bag named `sample` contains four data bag items: `abc`, `bar`,
`baz`, and `quz`. All of the items that are exclusive to `bar` and `foo`
can be searched for using an exclusive search pattern.

To search using an exclusive range, enter the following:

```bash
knife search sample "id:{bar TO foo}"
```

where curly braces (`{ }`) are used to define the range.

#### Fuzzy Matching

A fuzzy matching search pattern is used to search based on the proximity
of two strings of characters. An (optional) integer may be used as part
of the search query to more closely define the proximity. A fuzzy
matching search pattern has the following syntax:

```ruby
"search_query"~edit_distance
```

where `search_query` is the string that will be used during the search
and `edit_distance` is the proximity. A tilde ("\~") is used to separate
the edit distance from the search query.

To use a fuzzy search pattern enter something similar to:

```bash
knife search client "name:boo~"
```

where `boo~` defines the fuzzy search pattern. This will return
something similar to:

```json
{
  "total": 1,
  "start": 0,
  "rows": [
    {
      "public_key": "too long didn't read",
      "name": "foo",
      "_rev": "1-f11a58043906e33d39a686e9b58cd92f",
      "json_class": "Chef::ApiClient",
      "admin": false,
      "chef_type": "client"
    }
  ]
}
```

### About Operators

An operator can be used to ensure that certain terms are included in the
results, are excluded from the results, or aren't included even when
other aspects of the query match. Searches can use the following
operators:

`AND`
: Use to find a match when both terms exist.

`OR`
: Use to find a match if either term exists.

`NOT`
: Use to exclude the term after `NOT` from the search results.

Operators must be in ALL CAPS. Parentheses can be used to group clauses
and to form sub-queries.

<!-- markdownlint-disable-file MD033 -->

<div class="admonition-warning">
<p class="admonition-warning-title">Warning</p>
<div class="admonition-warning-text">

Using `AND NOT` together may trigger an error. For example:

```bash
ERROR: knife search failed: invalid search query:
'datacenter%3A123%20AND%20NOT%20hostname%3Adev-%20AND%20NOT%20hostanem%3Asyslog-'
Parse error at offset: 38 Reason: Expected one of \ at line 1, column 42 (byte 42) after AND
```

Use `-` instead of `NOT`. For example:

```bash
knife search sample "id:foo AND -id:bar"
```

</div>
</div>

#### AND

To join queries using the `AND` boolean operator, enter the following:

```bash
knife search sample "id:b* AND animal:dog"
```

to return something like:

```bash
{
  "total": 1,
  "start": 0,
  "rows": [
    {
      "comment": "an item named baz",
      "id": "baz",
      "animal": "dog"
    }
  ]
}
```

Or, to find all of the computers running on the Windows
platform that are associated with a role named `jenkins`, enter:

```bash
knife search node 'platform:windows AND roles:jenkins'
```

to return something like:

```bash
2 items found

Node Name:   windows-server-2012r2.domain.com
Environment: _default
FQDN:        windows-server-2012r2
IP:          0000::0000:0000:0000:0000
Run List:    role[jenkins-windows]
Roles:       jenkins-windows, jenkins
Recipes:     jenkins-client::windows, jenkins::node_windows
Platform:    windows 6.3.9600
Tags:

Node Name:   123-windows-2012r2-amd64-builder
Environment: _default
FQDN:        ABC-1234567890AB
IP:          123.45.6.78
Run List:    role[123-windows-2012r2-amd64-builder]
Roles:       123-windows-2012r2-amd64-builder, jenkins
Recipes:     jenkins::node_windows, git_windows
Platform:    windows 6.3.9600
Tags:
```

#### NOT

To negate search results using the `NOT` boolean operator, enter the
following:

```bash
knife search sample "(NOT id:foo)"
```

to return something like:

```bash
{
  "total": 4,
  "start": 0,
  "rows": [
    {
      "comment": "an item named bar",
      "id": "bar",
      "animal": "cat"
    },
    {
      "comment": "an item named baz",
      "id": "baz"
      "animal": "dog"
    },
    {
      "comment": "an item named abc",
      "id": "abc",
      "animal": "unicorn"
    },
    {
      "comment": "an item named qux",
      "id": "qux",
      "animal", "penguin"
    }
  ]
}
```

#### OR

To join queries using the `OR` boolean operator, enter the following:

```bash
knife search sample "id:foo OR id:abc"
```

to return something like:

```bash
{
  "total": 2,
  "start": 0,
  "rows": [
    {
      "comment": "an item named foo",
      "id": "foo",
      "animal": "pony"
    },
    {
      "comment": "an item named abc",
      "id": "abc",
      "animal": "unicorn"
    }
  ]
}
```

### Special Characters

A special character can be used to fine-tune a search query and to
increase the accuracy of the search results. The following characters
can be included within the search query syntax, but each occurrence of a
special character must be escaped with a backslash (`\`), also (`/`)
must be escaped against the Elasticsearch:

```ruby
+  -  &&  | |  !  ( )  { }  [ ]  ^  "  ~  *  ?  :  \  /
```

For example:

```ruby
\(1\+1\)\:2
```

## Options

{{< note >}}

{{< readfile file="content/workstation/26.0/reusable/md/knife_common_see_common_options_link.md" >}}

{{< /note >}}

This subcommand has the following options:

`-a ATTR`, `--attribute ATTR`

: The attribute (or attributes) to show.

`-b ROW`, `--start ROW`

: The row at which return results begin.

`-f FILTER`, `--filter-result FILTER`

: Use to filter the search output based on the pattern that matches the specified `FILTER`. Only attributes in the `FILTER` will returned. For example: `\"ServerName=name, Kernel=kernel.version\`.

`-i`, `--id-only`

: Show only matching object IDs.

`INDEX`

: The name of the index to be queried: `client`, `environment`, `node`, `role`, or `DATA_BAG_NAME`. Default index: `node`.

`-l`, `--long`

: Display all attributes in the output and show the output as JSON.

`-m`, `--medium`

: Display normal attributes in the output and to show the output as JSON.

`-q SEARCH_QUERY`, `--query SEARCH_QUERY`

: Protect search queries that start with a hyphen (-). A `-q` query may be specified as an argument or an option, but not both.

`-r`, `--run-list`

: Show only the run-list.

`-R INT`, `--rows INT`

: The number of rows to be returned.

`SEARCH_QUERY`

: The search query used to identify a list of items on a Chef Infra Server. This option uses the same syntax as the `search` subcommand.

## Examples

The following examples show how to use this knife subcommand:

**Search by platform ID**

To search for the IDs of all nodes running on the Amazon EC2 platform,
enter:

```bash
knife search node 'ec2:*' -i
```

to return something like:

```bash
4 items found

ip-0A7CA19F.ec2.internal

ip-0A58CF8E.ec2.internal

ip-0A58E134.ec2.internal

ip-0A7CFFD5.ec2.internal
```

**Search by instance type**

To search for the instance type (flavor) of all nodes running on the
Amazon EC2 platform, enter:

```bash
knife search node 'ec2:*' -a ec2.instance_type
```

to return something like:

```bash
4 items found

ec2.instance_type:  m1.large
id:                 ip-0A7CA19F.ec2.internal

ec2.instance_type:  m1.large
id:                 ip-0A58CF8E.ec2.internal

ec2.instance_type:  m1.large
id:                 ip-0A58E134.ec2.internal

ec2.instance_type:  m1.large
id:                 ip-0A7CFFD5.ec2.internal
```

**Search by recipe**

To search for recipes that are used by a node, use the `recipes`
attribute to search for the recipe names, enter something like:

```bash
knife search node 'recipes:recipe_name'
```

or:

```bash
knife search node '*:*' -a recipes | grep 'recipe_name'
```

**Search by cookbook, then recipe**

To search for cookbooks on a node, use the `recipes` attribute followed
by the `cookbook::recipe` pattern, escaping both of the `:` characters.
For example:

```bash
knife search node 'recipes:cookbook_name\:\:recipe_name'
```

**Search by node**

To search for all nodes running Ubuntu, enter:

```bash
knife search node 'platform:ubuntu'
```

**Search by node and environment**

To search for all nodes running CentOS in the production environment,
enter:

```bash
knife search node 'chef_environment:production AND platform:centos'
```

**Search for nested attributes**

To find a nested attribute, use a pattern similar to the following:

```bash
knife search node <query_to_run> -a <main_attribute>.<nested_attribute>
```

**Search for multiple attributes**

To build a search query to use more than one attribute, use an
underscore (`_`) to separate each attribute. For example, the following
query will search for all nodes running a specific version of Ruby:

```bash
knife search node "languages_ruby_version:2.7.0"
```

**Search for nested attributes using a search query**

To build a search query that can find a nested attribute:

```bash
knife search node name: <node_name> -a kernel.machine
```

**Use a test query**

To test a search query that will be used in a `knife ssh` subcommand:

```bash
knife search node "role:web NOT name:web03"
```

where the query in the previous example will search all servers that
have the `web` role, but not on the server named `web03`.
