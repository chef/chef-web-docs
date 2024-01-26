+++
title = "azure_microsoft_defender_setting Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_microsoft_defender_setting"
identifier = "inspec/resources/azure/azure_microsoft_defender_setting Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_microsoft_defender_setting` Chef InSpec audit resource to test the properties of a Microsoft Defender for Cloud Setting configuration.

## Syntax

```ruby
describe azure_microsoft_defender_setting(name: 'SETTING_NAME') do
  it { should exist }
end
```

## Parameters

`name`
: The name of the resource.

## Properties

`id`
: The ID of the resource.

`name`
: The name of the resource.

`kind`
: The resource kind.

`type`
: The resource type.

`properties.enabled`
: Is the alert sync setting enabled.

See the [Azure documentation on Defender for Cloud Settings configuration](https://learn.microsoft.com/en-us/rest/api/defenderforcloud/settings/get?tabs=HTTP) for additional information. You may access any attribute in the response with the key names separated by dots (`.`).

## Examples

### Test if a name exists

This resource does not have any examples.

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result.

```ruby
describe azure_microsoft_defender_setting(name: 'SETTING_NAME') do
  it { should exist }
end
```

Use `should_not` if you expect zero matches.

```ruby
describe azure_microsoft_defender_setting(name: 'SETTING_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal. Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.
