In 64-bit versions of Microsoft Windows,
`HKEY_LOCAL_MACHINE\SOFTWARE\Example` is a re-directed key. In the
following examples, because `HKEY_LOCAL_MACHINE\SOFTWARE\Example` is a
32-bit key, the output will be "Found 32-bit key" if they are run on a
version of Microsoft Windows that is 64-bit:

``` ruby
registry_key "HKEY_LOCAL_MACHINE\\SOFTWARE\\Example" do
  architecture :i386
  recursive true
  action :create
end
```

or:

``` ruby
registry_key "HKEY_LOCAL_MACHINE\\SOFTWARE\\Example" do
  architecture :x86_64
  recursive true
  action :delete_key
end
```

or:

``` ruby
ruby_block 'check 32-bit' do
  block do
    puts 'Found 32-bit key'
  end
  only_if {
    registry_key_exists?("HKEY_LOCAL_MACHINE\SOFTWARE\\Example",
    :i386)
  }
end
```

or:

``` ruby
ruby_block 'check 64-bit' do
  block do
    puts 'Found 64-bit key'
  end
  only_if {
    registry_key_exists?("HKEY_LOCAL_MACHINE\\SOFTWARE\\Example",
    :x86_64)
  }
end
```