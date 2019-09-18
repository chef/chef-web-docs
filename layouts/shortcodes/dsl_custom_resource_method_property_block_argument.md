Any properties that are marked `identity: true` or
`desired_state: false` will be available from `load_current_value`. If
access to other properties of a resource is needed, use a block argument
that contains all of the properties of the requested resource. For
example:

``` ruby
resource_name :file

load_current_value do |desired|
  puts "The user typed content = #{desired.content} in the resource"
end
```