+++
title = "Partials"
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Partials"
    identifier = "chef_infra/cookbook_reference/custom_resources/partials"
    parent = "chef_infra/cookbook_reference/custom_resources"
    weight = 20
+++

[InfoQ article](https://www.infoq.com/news/2020/05/chef-infra-16/)

Resoruce partials are a way of DRYing up resource code.

If you have three resources all which require the proprties, `user` and `group` to be set. You can write the property definition in one file and include it in the three resources.

The `use` method works similarly to the Ruby `require_relative` command.

```ruby
# resources/_partial/_user.rb
property :user,
        String,
        default: 'haproxy'

property :group, String
        String,
        default: 'haproxy'
```

```ruby
# resources/backend.rb
use '_partial/_user'
```

```ruby
# resources/frontend.rb
use '_partial/_user'
```
