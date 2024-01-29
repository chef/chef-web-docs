+++
title = "azure_migrate_assessment Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_assessment"
identifier = "inspec/resources/azure/azure_migrate_assessment Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_assessment` InSpec audit resource to test the properties related to the Azure Migrate assessment.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name`, `resource_group`, `project_name`, and `group_name` are required parameters.

```ruby
describe azure_migrate_assessment(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', group_name: 'GROUP_NAME', NAME: 'ASSESSMENT_NAME') do
  it                                      { should exist }
  its('name')                             { should cmp 'ASSESSMENT_NAME' }
  its('type')                             { should cmp 'Microsoft.Migrate/assessmentprojects/groups/assessments' }
end
```

```ruby
describe azure_migrate_assessment(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', group_name: 'GROUP_NAME', NAME: 'ASSESSMENT_NAME') do
  it  { should exist }
end
```

## Parameters

`name`
: Name of the Azure Migrate assessment to test.

`resource_group`
: Azure resource group where the targeted resource resides.

`project_name`
: Azure Migrate assessment project.

`group_name`
: Unique name of a group within a project.

The parameter set should be provided for a valid query are `resource_group`, `project_name`, `group_name`, and `name`.

## Properties

`id`
: Path reference to the assessment.

`name`
: Unique name of an assessment.

`type`
: Object type.

`eTag`
: For optimistic concurrency control.

`properties`
: Properties of the assessment.

`properties.azureDiskType`
: Storage type selected for this disk.

`properties.currency`
: Currency to report the prices.

`properties.sizingCriterion`
: Assessment sizing criterion.

`properties.reservedInstance`
: Azure reserved instance.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Refer to the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/migrate/assessment/assessments/get) for a full list of available properties. Access any attribute in the response by separating the key names with a period (`.`).

## Examples

### Test that the migrate assessments have a minimum scaling factor

```ruby
describe azure_migrate_assessment(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', group_name: 'GROUP_NAME', NAME: 'ASSESSMENT_NAME') do
  its('properties.scalingFactor') { should eq 1.0 }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a Migrate Assessment is found, it will exist.

describe azure_migrate_assessment(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', group_name: 'GROUP_NAME', NAME: 'ASSESSMENT_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If Migrate Assessments are not found, it will not exist.

describe azure_migrate_assessment(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', group_name: 'GROUP_NAME', NAME: 'ASSESSMENT_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
