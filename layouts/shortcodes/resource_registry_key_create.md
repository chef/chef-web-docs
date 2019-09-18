Use a double-quoted string:

``` ruby
registry_key "HKEY_LOCAL_MACHINE\\path-to-key\\Policies\\System" do
  values [{
    name: 'EnableLUA',
    type: :dword,
    data: 0
  }]
  action :create
end
```

or a single-quoted string:

``` ruby
registry_key 'HKEY_LOCAL_MACHINE\path-to-key\Policies\System' do
  values [{
    name: 'EnableLUA',
    type: :dword,
    data: 0
  }]
  action :create
end
```