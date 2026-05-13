To enable a custom resource to run in Agentless Mode, add `target_mode: true` to the resource definition. For example:

```ruby
provides :resource_name, target_mode: true
...
```
