An **apt_package** resource block manages a package on a node,
typically by installing it. The simplest use of the **apt_package** resource is:

```ruby
apt_package 'package_name'
```

which will install the named package using all of the default options and the default action of `:install`.
