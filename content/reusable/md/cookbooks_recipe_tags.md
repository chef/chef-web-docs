You can add tags, remove tags, and check if nodes have a specific tag.

To add a tag in your recipe, use `tag` with the tag name you want to apply to a node.

```ruby
tag('tag-name')
```

To test if a machine is tagged with a specific tag, use `tagged?` with the tag name.

```ruby
tagged?('tag-name')
```

This will return `true` or `false`.

`tagged?` also accepts an array as an argument.

Remove a tag using `untag`.

```ruby
untag('tag-name')
```

For example:

```ruby
tag('test_node')

if tagged?('test_node')
  Chef::Log.info("Hey I'm #{node['tags']}")
end

untag('test_node')

unless tagged?('test_node')
  Chef::Log.info('I am not tagged')
end
```

Will return something like this:

```none
[Thu, 22 Jul 2010 18:01:45 +0000] INFO: Hey I'm test_node
[Thu, 22 Jul 2010 18:01:45 +0000] INFO: I am not tagged
```
