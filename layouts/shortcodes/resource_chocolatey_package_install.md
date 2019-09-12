``` ruby
chocolatey_package 'name of package' do
  action :install
end
```

**Install a package with options**

This example uses Chocolatey's `--checksum` option:

``` ruby
chocolatey_package 'name of package' do
  options '--checksum 1234567890'
  action :install
end
```