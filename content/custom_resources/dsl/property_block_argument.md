Any properties that are marked `identity: true`, `desired_state: false`, or `name_property: true` will be directly available from `load_current_value`.

If access to other properties of a resource is needed, use a block argument with load_current_value. The block argument will have the values of the requested resource. For example:

```ruby
# Example: Property is directly available
property :action, String, name_property: true
property :content, String

load_current_value do |new_resource|
  puts "The user requested action = #{action} in the resource"
  puts "The user typed content = #{new_resource.content} in the resource"
end
```

```ruby
# Example: Using a block argument to 
property :action, String
property :content, String

load_current_value do |new_resource|
  puts "The user requested action = #{new_resource.action} in the resource"
  puts "The user typed content = #{new_resource.content} in the resource"
end
```
