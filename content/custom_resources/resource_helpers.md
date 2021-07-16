+++
title = "Helpers"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Custom Resource Helpers"
    identifier = "chef_infra/cookbook_reference/custom_resources/helpers Library Helpers"
    parent = "chef_infra/cookbook_reference/custom_resources"
    weight = 50
+++

Helper classes enable users to share code between Custom Resources. Rspec method test are possible when code is abstracted into plain Ruby files.

### Example

To include the following helper from libraries/helpers.rb

```ruby
#libraries/helpers.rb
module Haproxy
  module cookbook
    module ResourceHelpers
      def haproxy_version
        version = Mixlib::ShellOut.new("haproxy -v | grep version | awk '{ print $3 }'")
        version.run_command.stdout.to_f
      end
    end
  end
end
```

Within a Custom Resource file, use the include directive in the action_class, to include all methods in the specified module.

```ruby
action_class do
  include Haproxy::Cookbook::ResourceHelpers
end
```
