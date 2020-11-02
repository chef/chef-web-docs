+++
title = "Configuration Helpers"
description = "Define dynamic plan configuration settings with plan helpers"

[menu]
  [menu.habitat]
    title = "Plan Configuration Helpers"
    identifier = "habitat/reference/plan-helpers Plan Tuning"
    parent = "habitat/reference"

+++
[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/plan_helpers.md)

Chef Habitat allows you to use [Handlebars-based](http://handlebarsjs.com) tuneables in your plan, and you can also use both built-in Handlebars helpers and Chef Habitat-specific helpers in defining your configuration logic.

## Built-in Helpers

You can use block expressions to add basic logic to your template such as checking if a value exists or iterating through a list of items.

Block expressions use a helper function to perform the logic.
The syntax is the same for all block expressions and looks like this:

```
{{#helper blockname}}
  {{expression}}
{{/helper}}
```

Chef Habitat supports the standard [built-in helpers](https://handlebarsjs.com/builtin_helpers.html):

- `if`
- `unless`
- `each`
- `with`
- `lookup`
- `>` ([partials](http://handlebarsjs.com/partials.html))
- `log`

{{< note >}}
Per [Handlebars Paths](http://handlebarsjs.com/#paths), when using `each` in a block expression, you must reference the parent context of that block to use any user-defined configuration values referenced _within_ the block, such as those that start with `cfg`. For example, if your block looked like the following, you must reference `cfg.port` from the parent context of the block:

```handlebars
{{#each svc.members ~}}
    server {{sys.ip}}:{{../cfg.port}}
  {{/each}}
```

{{< /note >}}

The most common block helpers that you will probably use are the `if` and `with` helpers.

if
: The `if` helper evaluates conditional statements. The values `false`,
0, "", as well as undefined values all evaluate to false in `if`
blocks.

Here's an example that will only write out configuration for the unixsocket tunable if a value was set by the user:

```handlebars
{{#if cfg.unixsocket ~}}
  unixsocket {{cfg.unixsocket}}
{{/if ~}}
```

{{< note >}}
The `~` indicates that whitespace should be omitted when rendering.
{{< /note >}}

TOML allows you to create sections (called [TOML tables](https://github.com/toml-lang/toml#table)) to better organize your configuration variables. For example, your `default.toml` or user defined TOML could have a `[repl]` section for variables controlling replication behavior. Here's what that looks like:

```toml
[repl]
backlog-size = 200
backlog-ttl = 100
disable-tcp-nodelay = no
```

When writing your template, you can use the `with` helper to reduce duplication:

```handlebars
{{#with cfg.repl ~}}
  repl-backlog-size {{backlog-size}}
  repl-backlog-ttl {{backlog-ttl}}
  repl-disable-tcp-nodelay {{disable-tcp-nodelay}}
{{/with ~}}
```

Helpers can also be nested and used together in block expressions. Here is another example from the redis.config file where the `if` and `with` helpers are used together to set up `core/redis` Chef Habitat services  in a leader-follower topology.

    {{#if svc.me.follower ~}}
      replicaof {{svc.leader.sys.ip}} {{svc.leader.cfg.port}}
    {/if ~}}

each
: Here's an example using each to render multiple server entries:

    {{#each cfg.servers as |server| ~}}
    server {
      host {{server.host}}
      port {{server.port}}
    }
    {{/each ~}}

You can also use each with `@key` and `this`. Here is an example that takes the `[env]` section of your default.toml and makes an env file you can source from your run hook:

    {{#each cfg.env ~}}
      export {{toUppercase @key}}={{this}}
    {{/each ~}}

You would specify the corresponding values in a TOML file using an [array of tables](https://github.com/toml-lang/toml#array-of-tables) like this:

    [[servers]]
    host = "host-1"
    port = 4545

    [[servers]]
    host = "host-2"
    port = 3434

And for both each and unless, you can use `@first` and `@last` to specify which item in an array you want to perform business logic on. For example:

    "mongo": {
      {{#each bind.database.members as |member| ~}}
        {{#if @first ~}}
          "host" : "{{member.sys.ip}}",
          "port" : "{{member.cfg.port}}"
        {{/if ~}}
      {{/each ~}}
    }

{{< note >}}
The `@first` and `@last` variables also work with the Chef Habitat helper `eachAlive`, and in the example above, it would be preferable to the built-in `each` helper because it checks whether the service is available before trying to retrieve any values.
{{< /note >}}

unless
: For `unless`, using `@last` can also be helpful when you need to optionally include delimiters. In the example below, the IP addresses of the alive members returned by the `servers` binding is comma-separated. The logic check `{{#unless @last}}, {{/unless}}` at the end ensures that the comma is written after each element except the last element.

    {{#eachAlive bind.servers.members as |member| ~}}
      "{{member.sys.ip}}"
      {{#unless @last ~}}, {{/unless ~}}
    {{/eachAlive ~}}]

## Plan Helpers

Chef Habitat's templating flavour includes a number of custom helpers for writing configuration and hook files.

toLowercase
: Returns the lowercase equivalent of the given string literal.

```handlebars
my_value={{toLowercase "UPPER-CASE"}}
```

toUppercase
: Returns the uppercase equivalent of the given string literal.

```handlebars
my_value={{toUppercase "lower-case"}}
```

strReplace
: Replaces all matches of a pattern within the given string literal.

```handlebars
my_value={{strReplace "this is old" "old" "new"}}
```

This sets `my_value` to "this is new".

pkgPathFor
: Returns the absolute filepath to the package directory of the package best resolved from the given package identifier. The named package must exist in the `pkg_deps` of the plan from which the template resides. The helper will return a nil string if the named package is not listed in the `pkg_deps`. As result you will always get what you expect and the template won't leak to other packages on the system.

Example Plan Contents:

```bash
pkg_deps=("core/jre8")
```

Example Template:

```handlebars
export JAVA_HOME={{pkgPathFor "core/jre8"}}
```

Example pointing to specific file in <code>core/nginx</code> package on disk:

```handlebars
{{pkgPathFor "core/nginx"}}/config/fastcgi.conf
```

eachAlive
: Iterates over a collection of members and renders the template for members that are marked alive.

```handlebars
{{~#eachAlive bind.backend.members as |member|}}
server ip {{member.sys.ip}}:{{member.cfg.port}}
{{~/eachAlive}}
```

toJson
: To output configuration data as JSON, you can use the `toJson` helper.

Given a default.toml that looks like:

```toml
[web]

[[servers]]
host = "host-1"
port = 4545

[[servers]]
host = "host-2"
port = 3434
```

and a template:

```handlebars
{{toJson cfg.web}}
```

when rendered, it will look like:

```json
{
  "servers": [
    {
      "host": "host-1",
      "port": 4545
    },
    {
      "host": "host-2",
      "port": 3434
    }
  ]
}
```

This can be useful if you have a configuration file that is in JSON format and
has the same structure as your TOML configuration data.

toToml
: The `toToml` helper can be used to output TOML.

Given a default.toml that looks like:

```toml default.toml
[web]

port = 80
```

and a template:

```handlebars
{{toToml cfg.web}}
```

when rendered, it will look like:

```toml
port = 80
```

This can be useful if you have an app that uses TOML as its configuration file
format, but may have not been designed for Chef Habitat, and you only need certain
parts of the configuration data in the rendered TOML file.

toYaml
: The `toYaml` helper can be used to output [YAML](https://yaml.org/).

Given a default.toml that looks like:

```toml default.toml
[web]

port = 80
```

and a template:

```handlebars
{{toYaml cfg}}
```

when rendered, it will look like:

```yaml
+++
web:
  port: 80
```

The helper outputs a YAML document (with a line beginning with `+++`), so it must be used to create complete documents: you cannot insert a section of YAML into an existing YAML document with this helper.

strJoin
: The `join` helper can be used to create a string with the variables in a list with a separator specified by you. For example, where `list: ["foo", "bar", "baz"]`, `{{strJoin list ","}}` would return `"foo,bar,baz"`.

You cannot join an object (e.g. `{{strJoin web}}`), but you could join the variables in an object (e.g. `{{strJoin web.list "/"}}`).

strConcat
: The `concat` helper can be used to connect multiple strings into one string without a separator. For example, `{{strConcat "foo" "bar" "baz"}}` would return `"foobarbaz"`.\

You cannot concatenate an object (e.g. `{{strConcat web}}`), but you could concatenate the variables in an object (e.g. `{{strConcat web.list}}`).
