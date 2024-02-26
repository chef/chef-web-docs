+++
title = "azure_microsoft_defender_settings Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_microsoft_defender_settings"
identifier = "inspec/resources/azure/azure_microsoft_defender_settings Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_microsoft_defender_settings` Chef InSpec audit resource to test the properties of multiple Microsoft Defender for Cloud Settings configurations.

## Syntax

```ruby
describe azure_microsoft_defender_settings do
  it { should exist }
end
```

## Parameters

No required parameters.

## Properties

`ids`
: The ID of the resource.

: **Field**: `id`

`names`
: The name of the resource.

: **Field**: `name`

`types`
: The type of the resource.

: **Field**: `type`

`kinds`
: The kind of the resource.

: **Field**: `kind`

`properties`
: The properties of the resource.

: **Field**: `properties`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

See the [Azure documentation on Defender for Cloud Settings configuration](https://learn.microsoft.com/en-us/rest/api/defenderforcloud/settings/list?tabs=HTTP) for additional information. You may access any attribute in the response with the key names separated by dots (`.`).

## Examples

This resource does not have any examples.

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control passes if the filter returns at least one result.

```ruby
describe azure_microsoft_defender_settings do
  it { should exist }
end
```

Use `should_not` if you expect zero matches.

```ruby
describe azure_microsoft_defender_settings do
  it { should_not exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal. Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.
