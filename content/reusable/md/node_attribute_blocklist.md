Attributes are blocklisted by attribute type, with each attribute type being blocklisted independently in the `client.rb` file.

The four attribute types are:

- `automatic`
- `default`
- `normal`
- `override`

The blocklist settings are:

`blocked_automatic_attributes`

: An array that blocklists `automatic` attributes, preventing blocklisted attributes from being saved. For example: `['packages']`.

  Default value: `nil`, all attributes are saved.

  If the array is empty, all attributes are saved.

`blocked_default_attributes`

: An array that blocklists `default` attributes, preventing blocklisted attributes from being saved. For example: `['filesystem/dev/disk0s2/size']`.

  Default value: `nil`, all attributes are saved.

  If the array is empty, all attributes are saved.

`blocked_normal_attributes`

: An array that blocklists `normal` attributes, preventing blocklisted attributes from being saved. For example: `['filesystem/dev/disk0s2/size']`.

  Default value: `nil`, all attributes are saved.

  If the array is empty, all attributes are saved.

`blocked_override_attributes`

: An array that blocklists `override` attributes, preventing blocklisted attributes from being saved. For example: `['map - autohome/size']`.

  Default value: `nil`, all attributes are saved.

  If the array is empty, all attributes are saved.

<!-- markdownlint-disable-file MD002 -->

#### Blocklisting Ohai (automatic) attributes

Use `blocked_automatic_attributes` to block attributes populated by Ohai's system information gathering.

Ohai gathers a large number of attributes that can consume a significant amount of storage space on the Chef Infra Server.
Many of these attributes may be considered highly valuable, while others could be blocklisted without any impact to data available in search.
Normal, default, and override attributes are typically much more important attributes used within cookbooks and are more likely to cause issues if they're blocklisted incorrectly.

##### Example

The following shows an example of automatic attribute data.

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

To blocklist the `filesystem` attributes and allow Infra Client to save the other attributes, update the `client.rb`.

```ruby
blocked_automatic_attributes ['filesystem']
```

This blocklist blocks Chef Infra Client from saving the `filesystem` and `map - autohome` attributes, but saves the `network` attributes.
