+++
title = "Policyfile compatibility"
draft = false
+++

To use Marketplace with a Policyfile, add it as a Supermarket source:

```ruby
default_source :supermarket, "https://marketplace.chef.io"
```

You can keep the public Chef Supermarket as a source and add Marketplace alongside it, the same way you'd add a private Supermarket:

```ruby
default_source :supermarket
default_source :supermarket, "https://marketplace.chef.io"
```

If a cookbook exists in more than one source, use `preferred_for` to specify which source Chef should use:

```ruby
default_source :supermarket
default_source :supermarket, "https://marketplace.chef.io" do |s|
  s.preferred_for "my-cookbook"
end
```

Use your existing Policyfile commands after you update your sources.
No Marketplace credentials are required.

| Public cookbook source | Marketplace source | Configuration change | Limitation |
|---|---|---|---|
| `default_source :supermarket` | `default_source :supermarket, "https://marketplace.chef.io"` | Add the Marketplace URL as an additional `default_source`. You can keep both sources. | Private Chef Supermarket content is out of scope. |

## Related information

- [Backward compatibility](/marketplace/backward_compatibility/)
- [About Policyfiles](/client/latest/policy/policyfile/)
- [Chef Supermarket](/supermarket/)
