+++
title = "SimplifyAptPpaSetup"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `SimplifyAptPpaSetup`

The full name of the cop is: `Chef/Modernize/SimplifyAptPpaSetup`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The apt_repository resource allows setting up PPAs without using the full URL to ppa.launchpad.net, which should be used to simplify the resource code in your cookbooks.

## Examples


#### incorrect

```ruby
  apt_repository 'atom-ppa' do
    uri 'http://ppa.launchpad.net/webupd8team/atom/ubuntu'
    components ['main']
    keyserver 'keyserver.ubuntu.com'
    key 'C2518248EEA14886'
  end
```

#### correct

```ruby
  apt_repository 'atom-ppa' do
    uri 'ppa:webupd8team/atom'
    components ['main']
    keyserver 'keyserver.ubuntu.com'
    key 'C2518248EEA14886'
  end
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
<td style="text-align:center">5.21.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
