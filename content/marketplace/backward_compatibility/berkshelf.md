+++
title = "Berkshelf compatibility"
draft = false
+++

To use Marketplace with Berkshelf, replace the public Chef Supermarket source in your `Berksfile`:

```ruby
source "https://marketplace.chef.io"
metadata
```

Use your existing Berkshelf commands, such as `berks install`, after you change the source.
No Marketplace credentials are required.

| Public cookbook source | Marketplace source | Configuration change | Limitation |
|---|---|---|---|
| `source "https://supermarket.chef.io"` | `source "https://marketplace.chef.io"` | Replace the source URL. | Private Chef Supermarket content is out of scope. |

## Related information

- [Backward compatibility](/marketplace/backward_compatibility/)
- [Berkshelf](/workstation/latest/tools/berkshelf/)
- [Chef Supermarket](/supermarket/)
