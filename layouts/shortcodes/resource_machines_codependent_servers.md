The following example shows how to create two identical machines, both
of which cannot exist without the other. The first **machine** resource
block creates the first machine by omitting the recipe that requires the
other machine to be defined. The second resource block creates the
second machine; because the first machine exists, both recipes can be
run. The third resource block applies the second recipe to the first
machine:

``` ruby
machine 'server_a' do
  recipe 'base_recipes'
end

machine 'server_b' do
  recipe 'base_recipes'
  recipe 'theserver'
end

machine 'server_a' do
  recipe 'theserver'
end
```