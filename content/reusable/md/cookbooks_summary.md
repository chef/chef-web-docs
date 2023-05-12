A cookbook is the fundamental unit of configuration and policy distribution in Chef Infra.

A cookbook defines a scenario and contains everything that is required to support that scenario:

- Recipes that specify which Chef Infra built-in resources to use, as well as the order in which they are to be applied
- Attribute values, which allow environment-based configurations such as `dev` or `production`.
- Custom Resources for extending Chef Infra beyond the built-in resources.
- Files and Templates for distributing information to systems.
- Custom Ohai Plugins for extending system configuration collection beyond the Ohai defaults.
- The `metadata.rb` file, which describes the cookbook itself and any dependencies it may have.
