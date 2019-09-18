Chef Infra Client will warn you if the Recipe DSL is provided by another
custom resource or built-in resource. For example:

``` ruby
class X < Chef::Resource
  provides :file
end

class Y < Chef::Resource
  provides :file
end
```

This will emit a warning that `Y` is overriding `X`. To disable this
warning, use `override: true`:

``` ruby
class X < Chef::Resource
  provides :file
end

class Y < Chef::Resource
  provides :file, override: true
end
```