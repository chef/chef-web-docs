The following example shows using multiple `Chef::Log` entry types:

```ruby
...

begin
  aws = Chef::DataBagItem.load(:aws, :main)
  Chef::Log.info("Loaded AWS information from DataBagItem aws[#{aws['id']}]")
rescue
  Chef::Log.fatal("Couldn't find the 'main' item in the 'aws' data bag")
  raise
end

...
```
