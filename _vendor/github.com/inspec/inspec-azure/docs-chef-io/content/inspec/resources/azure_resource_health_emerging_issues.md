+++
title = "azure_resource_health_emerging_issues Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_resource_health_emerging_issues"
identifier = "inspec/resources/azure/azure_resource_health_emerging_issues Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_resource_health_emerging_issues` InSpec audit resource to test the properties related to all Azure Resource Health Emerging issues.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_resource_health_emerging_issues` resource block returns all Azure Resource Health Emerging issues.

```ruby
describe azure_resource_health_emerging_issues do
  #...
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of names for all the resources.

: **Field**: `name`

`types`
: A list of types for all the resources.

: **Field**: `type`

`properties`
: A list of Properties for all the resources.

: **Field**: `properties`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

See [Azure's documentation](https://docs.microsoft.com/en-us/rest/api/resourcehealth/emerging-issues/get) for other available properties.

## Examples

### Test that there are emerging health issues that are of lower severity

```ruby
describe azure_resource_health_emerging_issues.where{ properties.select{|prop| prop.statusActiveEvents.select{ |event| event.severity == 'Warning' } } } do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no service health emerging issues are present.

describe azure_resource_health_emerging_issues do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one service health emerging issue.

describe azure_resource_health_emerging_issues do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
