<div class="admonition-warning"><p class="admonition-warning-title">Warning</p><div class="admonition-warning-text">

When attribute blocklist settings are used, any attribute defined in a blocklist will not be saved to the Chef Infra Server and any attribute that is not defined in a blocklist will be saved. Each attribute type must be blocklisted independently of the other attribute types. For example, if `automatic_attribute_blocklist` defines attributes that will not be saved, but `normal_attribute_blocklist`, `default_attribute_blocklist`, and `override_attribute_blocklist` are not defined, then all normal attributes, default attributes, and override attributes will be saved, as well as the automatic attributes that were not specifically excluded through blocklisting.

</div></div>

Attributes that should not be saved by a node may be blocklisted in the client.rb file. The blocklist is a Hash of keys that specify each attribute to be filtered out.

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
<td><code>automatic_attribute_blocklist</code></td>
<td>A hash that blocklists <code>automatic</code> attributes, preventing blocklisted attributes from being saved. For example: <code>['network/interfaces/eth0']</code>. Default value: <code>nil</code>, all attributes are saved. If the array is empty, all attributes are saved.</td>
</tr>
<tr class="even">
<td><code>default_attribute_blocklist</code></td>
<td>A hash that blocklists <code>default</code> attributes, preventing blocklisted attributes from being saved. For example: <code>['filesystem/dev/disk0s2/size']</code>. Default value: <code>nil</code>, all attributes are saved. If the array is empty, all attributes are saved.</td>
</tr>
<tr class="odd">
<td><code>normal_attribute_blocklist</code></td>
<td>A hash that blocklists <code>normal</code> attributes, preventing blocklisted attributes from being saved. For example: <code>['filesystem/dev/disk0s2/size']</code>. Default value: <code>nil</code>, all attributes are saved. If the array is empty, all attributes are saved.</td>
</tr>
<tr class="even">
<td><code>override_attribute_blocklist</code></td>
<td>A hash that blocklists <code>override</code> attributes, preventing blocklisted attributes from being saved. For example: <code>['map - autohome/size']</code>. Default value: <code>nil</code>, all attributes are saved. If the array is empty, all attributes are saved.</td>
</tr>
</tbody>
</table>

<div class="admonition-warning">

<p class="admonition-warning-title">Warning</p>

<div class="admonition-warning-text">

The recommended practice is to use only `automatic_attribute_blocklist` for blocklisting attributes. This is primarily because automatic attributes generate the most data, but also that normal, default, and override attributes are typically much more important attributes and are more likely to cause issues if they are blocklisted incorrectly.

</div>

</div>

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
automatic_attribute_blocklist ['filesystem']
```

When a blocklist is defined, any attribute of that type that is not specified in that attribute blocklist **will** be saved. So based on the previous blocklist for automatic attributes, the `filesystem` and `map - autohome` attributes will not be saved, but the `network` attributes will.

For attributes that contain slashes (`/`) within the attribute value, such as the `filesystem` attribute `'/dev/diskos2'`, use an array. For

example:

```ruby
automatic_attribute_blocklist [['filesystem', '/dev/diskos2']]
```
