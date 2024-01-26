+++
title = "azure_managed_applications Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_managed_applications"
identifier = "inspec/resources/azure/azure_managed_applications Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_managed_applications` InSpec audit resource to test the properties related to all Azure Managed applications.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_managed_applications` resource block returns all Azure Managed applications.

```ruby
describe azure_managed_applications do
  #...
end
```

## Parameters

`resource_group`  _(optional)_
: Azure resource group where the targeted resource resides.

## Properties

`ids`
: A list of resource IDs.

: **Field**: `id`

`names`
: A list of resource Names.

: **Field**: `name`

`types`
: A list of the resource types.

: **Field**: `type`

`properties`
: A list of properties for all the Managed applications.

: **Field**: `properties`

`locations`
: A list of the resource locations.

: **Field**: `location`

`identities`
: A list of the identity of the resources.

: **Field**: `identity`

`plans`
: A list of the plan information.

: **Field**: `plan`

`provisioningStates`
: A list of provisioning states of the app.

: **Field**: `provisioningState`

`publisherTenantIds`
: A list of the publisher tenant ID.

: **Field**: `publisherTenantId`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through Managed applications by their names

```ruby
azure_managed_applications(resource_group: 'RESOURCE_GROUP').names.each do |name|
  describe azure_managed_application(resource_group: 'RESOURCE_GROUP', name: name) do
    it { should exist }
  end
end
```

### Test that there are Managed applications that are successfully provisioned

```ruby
describe azure_managed_applications(resource_group: 'RESOURCE_GROUP').where(provisioningState: 'Succeeded') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Managed applications are present.

describe azure_managed_applications(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Managed application.

describe azure_managed_applications(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
