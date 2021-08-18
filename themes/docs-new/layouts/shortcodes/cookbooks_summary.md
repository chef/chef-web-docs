A cookbook is the fundamental unit of configuration and policy distribution in Chef Infra.

A cookbook defines a scenario and contains everything that is required to support that scenario:

- Recipes that specify Chef Infra built-in resources to use and the order in which they are to be applied
- Attribute values allowing different configuratinos to be applied based on environments such as dev vs. production.
- Custom Resources used to extend Chef Infra beyond the built-in resources.
- Files and Templates for distributing information to systems.
- Custom Ohai Plugins for extending system configuration collection beyond the Ohai defaults.
- The `metadata.rb` file, which describes the cookbook itself and any dependencies it may have.