To install a gem while Chef Infra Client is configuring the node (the
“converge phase”), set the `compile_time` property to `false`:

``` ruby
chef_gem 'right_aws' do
  compile_time false
  action :install
end
```

To install a gem while the resource collection is being built (the
“compile phase”), set the `compile_time` property to `true`:

``` ruby
chef_gem 'right_aws' do
  compile_time true
  action :install
end
```