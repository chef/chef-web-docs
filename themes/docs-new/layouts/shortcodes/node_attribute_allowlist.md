<div class="admonition-warning"><p class="admonition-warning-title">Warning</p><div class="admonition-warning-text">

When attribute allowlist settings are used, only the attributes defined in a allowlist will be saved and any attribute that is not defined in a allowlist will not be saved. Each attribute type is allowlisted independently of the other attribute types. For example, if `automatic_attribute_allowlist` defines attributes to be saved, but `normal_attribute_allowlist`, `default_attribute_allowlist`, and
`override_attribute_allowlist` are not defined, then all normal attributes, default attributes, and override attributes are saved, as well as the automatic attributes that were specifically included through allowlisting.

</div></div>

Attributes that should be saved by a node may be allowlisted in the client.rb file. The allowlist is a hash of keys that specifies each attribute to be saved.

Attributes are allowlisted by attribute type, with each attribute type being allowlisted independently. Each attribute type---`automatic`, `default`, `normal`, and `override`---may define allowlists by using the following settings in the client.rb file:

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
<td><code>allowed_automatic_attributes</code></td>
<td>A hash that allowlists <code>automatic</code> attributes, preventing non-allowlisted attributes from being saved. For example: <code>['network/interfaces/eth0']</code>. Default value: <code>nil</code>, all attributes are saved. If the hash is empty, no attributes are saved.</td>
</tr>
<tr class="even">
<td><code>allowed_default_attributes</code></td>
<td>A hash that allowlists <code>default</code> attributes, preventing non-allowlisted attributes from being saved. For example: <code>['filesystem/dev/disk0s2/size']</code>. Default value: <code>nil</code>, all attributes are saved. If the hash is empty, no attributes are saved.</td>
</tr>
<tr class="odd">
<td><code>allowed_normal_attributes</code></td>
<td>A hash that allowlists <code>normal</code> attributes, preventing non-allowlisted attributes from being saved. For example: <code>['filesystem/dev/disk0s2/size']</code>. Default value: <code>nil</code>, all attributes are saved. If the hash is empty, no attributes are saved.</td>
</tr>
<tr class="even">
<td><code>allowed_override_attributes</code></td>
<td>A hash that allowlists <code>override</code> attributes, preventing non-allowlisted attributes from being saved. For example: <code>['map - autohome/size']</code>. Default value: <code>nil</code>, all attributes are saved. If the hash is empty, no attributes are saved.</td>
</tr>
</tbody>
</table>

#### Allowlisting Ohai (automatic) Attributes

The recommended practice is to use `allowed_automatic_attributes` to allow specific attributes populated by Ohai's system information gathering. Ohai gathers a large number of attributes that can consume a signicant amount of storage space on the Chef Infra Server. Many of these attributes may be considered highly valuable, while others could be skipped without any impact to data available in search. Normal, default, and override attributes are typically much more important attributes used within cookbooks and are more likely to cause issues if they are ommited from an allowlist incorrectly.

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
