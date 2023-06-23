Attributes that should be saved by a node may be allowlisted in the client.rb file. The allowlist is a hash of keys that specifies each attribute to be saved.

Attributes are allowlisted by attribute type, with each attribute type being allowlisted independently. Each attribute type---`automatic`, `default`, `normal`, and `override`---may define allowlists by using the following settings in the client.rb file:

`allowed_automatic_attributes`

: A hash that allowlists `automatic` attributes, preventing non-allowlisted attributes from being saved. For example: `['network/interfaces/eth0']`. Default value: `nil`, all attributes are saved. If the hash is empty, no attributes are saved.

`allowed_default_attributes`

: A hash that allowlists `default` attributes, preventing non-allowlisted attributes from being saved. For example: `['filesystem/dev/disk0s2/size']`. Default value: `nil`, all attributes are saved. If the hash is empty, no attributes are saved.

`allowed_normal_attributes`

: A hash that allowlists `normal` attributes, preventing non-allowlisted attributes from being saved. For example: `['filesystem/dev/disk0s2/size']`. Default value: `nil`, all attributes are saved. If the hash is empty, no attributes are saved.

`allowed_override_attributes`

: A hash that allowlists `override` attributes, preventing non-allowlisted attributes from being saved. For example: `['map - autohome/size']`. Default value: `nil`, all attributes are saved. If the hash is empty, no attributes are saved.

<!-- markdownlint-disable-file MD033 -->

#### Allowlisting Ohai (automatic) attributes

The recommended practice is to use `allowed_automatic_attributes` to allow specific attributes populated by Ohai's system information gathering. Ohai gathers a large number of attributes that can consume a significant amount of storage space on the Chef Infra Server. Many of these attributes may be considered highly valuable, while others could be skipped without any impact to data available in search. Normal, default, and override attributes are typically much more important attributes used within cookbooks and are more likely to cause issues if they are omitted from an allowlist incorrectly.

For example, automatic attribute data similar to:

```json
{
  "filesystem" => {
    "/dev/disk0s2" => {
      "size" => "10mb"
    },
    "map - autohome" => {
      "size" => "10mb"
    }
  },
  "network" => {
    "interfaces" => {
      "eth0" => {...},
      "eth1" => {...},
    }
  }
}
```

To allowlist the `network` attributes and prevent the other attributes from being saved, update the client.rb file:

```ruby
allowed_automatic_attributes ['network/interfaces/']
```

When a allowlist is defined, any attribute of that type that is not specified in that attribute allowlist **will not** be saved. So based on the previous allowlist for automatic attributes, the `filesystem` and `map - autohome` attributes will not be saved, but the `network` attributes will.

Leave the value empty to prevent all attributes of that attribute type from being saved:

```ruby
allowed_automatic_attributes []
```

For attributes that contain slashes (`/`) within the attribute value, such as the `filesystem` attribute `'/dev/diskos2'`, use an array. For example:

```ruby
allowed_automatic_attributes [['filesystem', '/dev/diskos2']]
```
