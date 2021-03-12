<div class="admonition-warning"><p class="admonition-warning-title">Warning</p><div class="admonition-warning-text">

When attribute blocklist settings are used, any attribute defined in a blocklist will not be saved to the Chef Infra Server and any attribute that is not defined in a blocklist will be saved. Each attribute type must be blocklisted independently of the other attribute types. For example, if `blocked_automatic_attributes` defines attributes that will not be saved, but `blocked_normal_attributes`, `blocked_default_attributes`, and `blocked_override_attributes` are not defined, then all normal attributes, default attributes, and override attributes will be saved, as well as the automatic attributes that were not specifically excluded through blocklisting.

</div></div>

Attributes that should not be saved by a node may be blocklisted in the [client.rb](/config_rb_client/) file. The blocklist is a Hash of keys that specify each attribute to be filtered out.

Attributes are blocklisted by attribute type, with each attribute type being blocklisted independently. Each attribute type---`automatic`, `default`, `normal`, and `override`---may define blocklists by using the following settings in the client.rb file:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Setting</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>blocked_automatic_attributes</code></td>
<td>A hash that blocklists <code>automatic</code> attributes, preventing blocklisted attributes from being saved. For example: <code>['network/interfaces/eth0']</code>. Default value: <code>nil</code>, all attributes are saved. If the array is empty, all attributes are saved.</td>
</tr>
<tr class="even">
<td><code>blocked_default_attributes</code></td>
<td>A hash that blocklists <code>default</code> attributes, preventing blocklisted attributes from being saved. For example: <code>['filesystem/dev/disk0s2/size']</code>. Default value: <code>nil</code>, all attributes are saved. If the array is empty, all attributes are saved.</td>
</tr>
<tr class="odd">
<td><code>blocked_normal_attributes</code></td>
<td>A hash that blocklists <code>normal</code> attributes, preventing blocklisted attributes from being saved. For example: <code>['filesystem/dev/disk0s2/size']</code>. Default value: <code>nil</code>, all attributes are saved. If the array is empty, all attributes are saved.</td>
</tr>
<tr class="even">
<td><code>blocked_override_attributes</code></td>
<td>A hash that blocklists <code>override</code> attributes, preventing blocklisted attributes from being saved. For example: <code>['map - autohome/size']</code>. Default value: <code>nil</code>, all attributes are saved. If the array is empty, all attributes are saved.</td>
</tr>
</tbody>
</table>

#### Blocklisting Ohai (automatic) Attributes

The recommended practice is to use `blocked_automatic_attributes` to block attributes populated by Ohai's system information gathering. Ohai gathers a large number of attributes that can consume a signicant amount of storage space on the Chef Infra Server. Many of these attributes may be considered highly valuable, while others could be blocklisted without any impact to data available in search. Normal, default, and override attributes are typically much more important attributes used within cookbooks and are more likely to cause issues if they are blocklisted incorrectly.

For example, automatic attribute data similar to:

```javascript
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

For attributes that contain slashes (`/`) within the attribute value, such as the `filesystem` attribute `'/dev/diskos2'`, use an array. For

example:

```ruby
blocked_automatic_attributes [['filesystem', '/dev/diskos2']]
```
