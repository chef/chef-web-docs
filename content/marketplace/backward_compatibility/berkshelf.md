+++
title = "Berkshelf compatibility"
draft = false
+++

To use Marketplace with Berkshelf, add it as a source in your `Berksfile`:

```ruby
source "https://marketplace.chef.io"
metadata
```

Berkshelf processes sources in the order they're defined, and stops at the first source with a suitable cookbook.
You can keep the public Chef Supermarket as a source and add Marketplace alongside it, the same way you'd add a private Supermarket:

```ruby
source "https://marketplace.chef.io"
source "https://supermarket.chef.io"
metadata
```

List Marketplace first if you want Berkshelf to prefer it over the public Chef Supermarket.
Use your existing Berkshelf commands, such as `berks install`, after you update your sources.
No Marketplace credentials are required.

| Public cookbook source | Marketplace source | Configuration change | Limitation |
|---|---|---|---|
| `source "https://supermarket.chef.io"` | `source "https://marketplace.chef.io"` | Add the source URL. You can keep both sources. | Private Chef Supermarket content is out of scope. |

## Related information

- [Backward compatibility](/marketplace/backward_compatibility/)
- [Berkshelf](/workstation/latest/tools/berkshelf/)
- [Chef Supermarket](/supermarket/)
