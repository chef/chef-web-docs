### Introduced

Chef Infra Client <!-- TODO:  -->

Use the `provides` method to associate multiple custom resource files with the same resources name
For example:

```ruby
# Provide my_custom_resource to Redhat 7 and above
provides :my_custom_resource, platform: 'redhat' do |node|
  node['platform_version'].to_i >= 7
end

# Provide my_custom_resource to all Redhat platforms
provides :my_custom_resource, platform: 'redhat'

# Provide my_custom_resource to the RedHat platform family
provides :my_custom_resource, platform_family: 'rhel'

# Provide my_custom_resource to all linux machines
provides :my_custom_resource, os: 'linux'

# Provide my_custom_resource, useful if your resource file is not named the same as the resource you want to provide
provides :my_custom_resource
```

This allows you to use multiple custom resources files that provide the
same resource to the user, but for different operating systems or
operation system versions. With this you can eliminate the need for
platform or platform version logic within your resources.

### Presidence

Use the `provides` method to associate a custom resource with the Recipe
DSL on different operating systems. When multiple custom resources use
the same DSL, specificity rules are applied to determine the priority,
from highest to lowest:

1. provides :my_custom_resource, platform_version: '0.1.2'
2. provides :my_custom_resource, platform: 'platform_name'
3. provides :my_custom_resource, platform_family: 'platform_family'
4. provides :my_custom_resource, os: 'operating_system'
5. provides :my_custom_resource
