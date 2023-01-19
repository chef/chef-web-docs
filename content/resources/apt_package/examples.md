**Install a package using package manager**:

```ruby
apt_package 'name of package' do
  action :install
end
```

**Install a package without specifying the default action**:

```ruby
apt_package 'name of package'
```

**Install multiple packages at once**:

```ruby
apt_package %w(package1 package2 package3)
```

**Install without using recommend packages as a dependency**:

```ruby
package 'apache2' do
  options '--no-install-recommends'
end
```
