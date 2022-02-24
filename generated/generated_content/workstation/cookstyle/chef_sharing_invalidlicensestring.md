+++
title = "InvalidLicenseString"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `InvalidLicenseString`

The full name of the cop is: `Chef/Sharing/InvalidLicenseString`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

metadata.rb license field should include a SPDX compliant string or "all right reserved" (not case sensitive)

list of valid SPDX.org license strings. To build an array run this ruby:
```ruby
require 'json'
require 'net/http'
json_data = JSON.parse(Net::HTTP.get(URI('https://raw.githubusercontent.com/spdx/license-list-data/master/json/licenses.json')))
licenses = json_data['licenses'].map {|l| l['licenseId'] }.sort
```

## Examples


#### incorrect

```ruby
license 'Apache 2.0'
```

#### correct

```ruby
license 'Apache-2.0'
license 'all rights reserved'
```

## Configurable attributes

<table>
<tbody><tr>
<th>Name</th>
<th>Default value</th>
<th>Configurable values</th>
</tr>
<tr>
<td style="text-align:center">Version Added</td>
<td style="text-align:center">5.2.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
