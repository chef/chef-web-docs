A **registry_key** resource block creates and deletes registry keys in
Microsoft Windows:

``` ruby
registry_key "HKEY_LOCAL_MACHINE\\...\\System" do
  values [{
    name: "NewRegistryKeyValue",
    type: :multi_string,
    data: ['foo\0bar\0\0']
  }]
  action :create
end
```

Use multiple registry key entries with key values that are based on node
attributes:

``` ruby
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\name_of_registry_key' do
  values [{name: 'key_name', type: :string, data: 'C:\Windows\System32\file_name.bmp'},
          {name: 'key_name', type: :string, data: node['node_name']['attribute']['value']},
          {name: 'key_name', type: :string, data: node['node_name']['attribute']['value']}
         ]
  action :create
end
```

The registry_key resource has the following syntax:

``` ruby
registry_key 'name' do
  architecture      Symbol # default value: :machine
  key               String # default value: 'name' unless specified
  recursive         true, false # default value: false
  values
  action            Symbol # defaults to :create if not specified
end
```

where

-   `registry_key` is the resource

-   `name` is the name of the resource block

-   `values` is a hash that contains at least one registry key to be
    created or deleted. Each registry key in the hash is grouped by
    brackets in which the `name:`, `type:`, and `data:` values for that
    registry key are specified.

-   `type:` represents the values available for registry keys in
    Microsoft Windows. Use `:binary` for REG_BINARY, `:string` for
    REG_SZ, `:multi_string` for REG_MULTI_SZ, `:expand_string` for
    REG_EXPAND_SZ, `:dword` for REG_DWORD, `:dword_big_endian` for
    REG_DWORD_BIG_ENDIAN, or `:qword` for REG_QWORD.

    <div class="alert-warning">

    `:multi_string` must be an array, even if there is only a single
    string.

    </div>

-   `action` identifies the steps Chef Infra Client will take to bring
    the node into the desired state

-   `architecture`, `key`, `recursive` and `values` are properties of
    this resource, with the Ruby type shown. See "Properties" section
    below for more information about all of the properties that may be
    used with this resource.