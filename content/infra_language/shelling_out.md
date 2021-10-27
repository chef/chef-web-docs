+++
title = "Chef Infra Language: Shelling Out"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Shelling Out"
    identifier = "chef_infra/infra_language/shelling_out.md Shelling Out"
    parent = "chef_infra/infra_language"
+++
<!-- markdownlint-disable-file MD026 -->
In most cases when you need to run a particular command in a cookbook, you'll want to use the [execute resource](/resources/execute/). Helper methods for shelling out can be useful when writing custom resources or other more advanced Ruby code.

## shell_out

The `shell_out` method can be used to run a command against the node, and then display the output to the console when the log level is set to `debug`.

The syntax for the `shell_out` method is as follows:

```ruby
shell_out(command_args)
```

where `command_args` is the command that is run against the node.

## shell_out!

The `shell_out!` method can be used to run a command against the node, display the output to the console when the log level is set to `debug`, and then raise an error when the method returns `false`.

The syntax for the `shell_out!` method is as follows:

```ruby
shell_out!(command_args)
```

where `command_args` is the command that is run against the node. This method will return `true` or `false`.
