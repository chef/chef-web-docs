+++
title = "Policyfile compatibility"
draft = false
+++

To use Marketplace with a Policyfile, configure Marketplace as the Supermarket source:

```ruby
default_source :supermarket, "https://marketplace.chef.io"
```

Use your existing Policyfile commands after you change the source URL.
No Marketplace credentials are required.

| Public cookbook source | Marketplace source | Configuration change | Limitation |
|---|---|---|---|
| `default_source :supermarket` | `default_source :supermarket, "https://marketplace.chef.io"` | Add the Marketplace URL to `default_source`. | Private Chef Supermarket content is out of scope. |

## Related information

- [Backward compatibility](/marketplace/backward_compatibility/)
- [About Policyfiles](/client/latest/policy/policyfile/)
- [Chef Supermarket](/supermarket/)
