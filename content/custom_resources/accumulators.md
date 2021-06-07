+++
title = "Accumulators"
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Accumulators"
    identifier = "chef_infra/cookbook_reference/custom_resources/accumulators"
    parent = "chef_infra/cookbook_reference/custom_resources"
    weight = 15
+++

This is an advanced topic. You should have already written a Custom Resource and be familiar with:

- the Chef template resource
- resource `[run_context](dsl/run_context.md)`

You will be able to use the accumulator pattern and be aware of it's draw backs.

## Overview

An accumulator is a programming pattern to gather multiple values together.

In the context of Custom Resources, this means we collect a set of inputs, usually a set of properties from multiple Custom Resources, and then apply the final collection to a resource.

If the software you are automating has a single configuration file, but you wish to split out each configuration section into it's own resource this can be done with the accumulator pattern

## Scope

We will cover

- x
- y
- c

For more information about run_context please see the [run_context](dsl/run_context.md) documentation.

## Drawbacks

Confusing

## Further Reading

- [here](https://github.com/chef/chef/issues/5438#issuecomment-351153222)
- [DNSimple](https://blog.dnsimple.com/2017/10/chef-accumulators/)
- [HAProxy](https://github.com/sous-chefs/haproxy/blob/a9c24d336c01828fef52cedae8cc445d8dbc21dd/libraries/resource.rb#L22)
