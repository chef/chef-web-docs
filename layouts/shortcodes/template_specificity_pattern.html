The pattern for template specificity depends on two things: the lookup
path and the source. The first pattern that matches is used:

1.  `/host-$fqdn/$source`
2.  `/$platform-$platform_version/$source`
3.  `/$platform/$source`
4.  `/default/$source`
5.  `/$source`

Use an array with the `source` property to define an explicit lookup
path. For example:

``` ruby
template '/test' do
  source ["#{node.chef_environment}.erb", 'default.erb']
end
```

The following example emulates the entire file specificity pattern by
defining it as an explicit path:

``` ruby
template '/test' do
  source %W(
    host-#{node['fqdn']}/test.erb
    #{node['platform']}-#{node['platform_version']}/test.erb
    #{node['platform']}/test.erb
    default/test.erb
  )
end
```