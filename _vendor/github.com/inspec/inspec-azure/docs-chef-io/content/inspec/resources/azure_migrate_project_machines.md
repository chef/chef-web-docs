+++
title = "azure_migrate_project_machines Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_project_machines"
identifier = "inspec/resources/azure/azure_migrate_project_machines Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_project_machines` InSpec audit resource to test the properties related to all Azure Migrate Project machines within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_migrate_project_machines` resource block returns all Azure Migrate Project machines within a project.

```ruby
describe azure_migrate_project_machines(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  #...
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`project_name`
: Azure Migrate project name.

The parameter set that should be provided for a valid query is `resource_group` and `project_name`.

## Properties

`ids`
: Path reference to the project machines.

: **Field**: `id`

`names`
: Unique names for all project machines.

: **Field**: `name`

`types`
: Type of the objects.

: **Field**: `type`

`properties`
: A list of properties for all the project machines.

: **Field**: `properties`

`discoveryData`
: The discovery details of all the machines published by various sources.

: **Field**: `discoveryData`

`assessmentData`
: The assessment details of all the machines published by various sources.

: **Field**: `assessmentData`

`migrationData`
: The migration details of all the machines published by various sources.

: **Field**: `migrationData`

`lastUpdatedTimes`
: The times of the last modification of all the machines.

: **Field**: `lastUpdatedTime`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through Migrate Project machines by their names

```ruby
azure_migrate_project_machines(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').names.each do |name|
  describe azure_migrate_project_machine(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', name: `NAME`) do
    it { should exist }
  end
end
```

### Test that there are Migrate Project machines with Windows OS

```ruby
describe azure_migrate_project_machines(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').where{ discoveryData.detect{ |data| data[:osType] == 'WINDOWSGUEST' } } do
  it { should exist }
end
```

### Test that the Migrate Project machines are of BIOS boot type

```ruby
describe azure_migrate_project_machines(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').where{ discoveryData.detect{ |data| data[:extendedInfo][:bootType] == 'BIOS' } } do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Migrate Project machines are present in the project and the resource group.

describe azure_migrate_project_machines(resource_group: 'migrate_vms', project_name: 'zoneA_migrate_project') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Migrate Project machine in the project and the resource group.

describe azure_migrate_project_machines(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
