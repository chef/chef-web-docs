Attributes are blocklisted by attribute type, with each attribute type being blocklisted independently. Each attribute type---`automatic`, `default`, `normal`, and `override`---may define blocklists by using the following settings in the client.rb file:

`blocked_automatic_attributes`

: An array that blocklists `automatic` attributes, preventing blocklisted attributes from being saved. For example: `['packages']`. Default value: `nil`, all attributes are saved. If the array is empty, all attributes are saved.

`blocked_default_attributes`

: An array that blocklists `default` attributes, preventing blocklisted attributes from being saved. For example: `['filesystem/dev/disk0s2/size']`. Default value: `nil`, all attributes are saved. If the array is empty, all attributes are saved.

`blocked_normal_attributes`

: An array that blocklists `normal` attributes, preventing blocklisted attributes from being saved. For example: `['filesystem/dev/disk0s2/size']`. Default value: `nil`, all attributes are saved. If the array is empty, all attributes are saved.

`blocked_override_attributes`

: An array that blocklists `override` attributes, preventing blocklisted attributes from being saved. For example: `['map - autohome/size']`. Default value: `nil`, all attributes are saved. If the array is empty, all attributes are saved.

<!-- markdownlint-disable-file MD002 -->

#### Blocklisting Ohai (automatic) attributes

The recommended practice is to use `blocked_automatic_attributes` to block attributes populated by Ohai's system information gathering. Ohai gathers a large number of attributes that can consume a significant amount of storage space on the Chef Infra Server. Many of these attributes may be considered highly valuable, while others could be blocklisted without any impact to data available in search. Normal, default, and override attributes are typically much more important attributes used within cookbooks and are more likely to cause issues if they are blocklisted incorrectly.

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

To blocklist the `filesystem` attributes and allow the other attributes to be saved, update the client.rb file:

```ruby
blocked_automatic_attributes ['filesystem']
```

When a blocklist is defined, any attribute of that type that is not specified in that attribute blocklist **will** be saved. So based on the previous blocklist for automatic attributes, the `filesystem` and `map - autohome` attributes will not be saved, but the `network` attributes will.
