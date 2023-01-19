**Install an alternative**:

```ruby
alternatives 'python install 2' do
  link_name 'python'
  path '/usr/bin/python2.7'
  priority 100
  action :install
end
```

**Set an alternative**:

```ruby
alternatives 'python set version 3' do
  link_name 'python'
  path '/usr/bin/python3'
  action :set
end
```

**Set the automatic alternative state**:

```ruby
alternatives 'python auto' do
  link_name 'python'
  action :auto
end
```

**Refresh an alternative**:

```ruby
alternatives 'python refresh' do
  link_name 'python'
  action :refresh
end
```

**Remove an alternative**:

```ruby
alternatives 'python remove' do
  link_name 'python'
  path '/usr/bin/python3'
  action :remove
end
```
