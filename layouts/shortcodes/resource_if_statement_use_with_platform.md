The following example shows how an if statement can be used with the
`platform?` method in the Chef Infra Language to run code specific to Microsoft
Windows. The code is defined using the **ruby_block** resource:

```ruby
if platform?('windows')
  chocolatey_package 'firefox'
else
  package 'firefox'
end
```
