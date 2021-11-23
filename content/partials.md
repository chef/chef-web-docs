+++
title = "Partials"
gh_repo = "chef-web-docs"

product = ["client", "workstation"]

[menu]
  [menu.infra]
    title = "Partials"
    identifier = "chef_infra/resources/custom_resources/partials"
    parent = "chef_infra/resources/custom_resources"
    weight = 40
+++

[InfoQ article](https://www.infoq.com/news/2020/05/chef-infra-16/)

Resource partials are a way of allowing resources to share common code. We recommend using partials any time you need to share code across three or more resources.

If you have three resources all which require the properties, `user` and `group` to be set. Instead of writing those property definitions in each of those files, you can write the property definition in one file and include it in the three resources.

The `use` method works similarly to the Ruby `require_relative` command.

Write the common properties and place them in a folder within the resources folder. This will stop Chef from considering them to be full resources.

```ruby
# resources/_partial/_user.rb
property :user,
        String,
        default: 'haproxy'

property :group, String
        String,
        default: 'haproxy'
```

Then include them in each of the three resources with the use directive:

```ruby
# resources/backend.rb
use '_partial/_user'
```

```ruby
# resources/frontend.rb
use '_partial/_user'
```
