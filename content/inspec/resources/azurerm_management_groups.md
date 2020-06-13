+++
title = "azurerm_management_groups resource"
draft = false

[menu]
  [menu.inspec]
    title = "azurerm_management_groups"
    identifier = "inspec/resources/azurerm_management_groups.md azurerm_management_groups resource"
    parent = "inspec/resources"
+++


Use the `azurerm_management_groups` InSpec audit resource to test properties related to
management groups.

<br />

## Azure REST API version

This resource interacts with version `2018-03-01-preview` of the Azure
Management API. For more information see the [official Azure documentation](https://docs.microsoft.com/en-us/rest/api/resources/managementgroups/list).

At the moment, there doesn't appear to be a way to select the version of the
Azure API docs. If you notice a newer version being referenced in the official
documentation please open an issue or submit a pull request using the updated
version.

## Availability

### Installation

This resource is available in the `inspec-azure` [resource
pack](https://www.inspec.io/docs/reference/glossary/#resource-pack). To use it,
add the following to your `inspec.yml` in your top-level profile:

    depends:
      - name: inspec-azure
        git: https://github.com/inspec/inspec-azure.git

You'll also need to setup your Azure credentials; see the resource pack
[README](https://github.com/inspec/inspec-azure#inspec-for-azure).

## Syntax

    describe azurerm_management_groups do
      ...
    end

<br />

## Examples

### Check attributes of all management groups

  describe azurerm_management_groups do
    its('ids')           { should include "/providers/Microsoft.Management/managementGroups/mg_id" }
    its('names')         { should include "parent_mg" }
    its('types')         { should include '/providers/Microsoft.Management/managementGroups' }
  end

### Filter results to inspect the properties of specific Management Group.
  describe azurerm_management_groups.where(name: 'mg_parent').entries.first do
    its('properties') { should have_attributes(:tenantId => tenant_id, :displayName => parent_dn)}
  end
<br />

## Parameters

N/A

## Attributes

  - `ids`
  - `types`
  - `names`
  - `properties`

### ids

The management group ids.

### types

The management group types.

### names

The management group names.

### properties

Additional properties relating to management groups.

### Other Attributes

There are additional attributes that may be accessed that we have not
documented. Please take a look at the [Azure documentation](#-Azure-REST-API-version).
Any attribute in the response may be accessed with the key names separated by
dots (`.`).

The API may not always return keys that do not have any associated data. There
may be cases where the deeply nested property may not have the desired
attribute along your call chain. If you find yourself writing tests against
properties that may be nil, fork this resource pack and add an accessor to the
resource. Within that accessor you'll be able to guard against nil keys. Pull
requests are always welcome.

## Matchers

This InSpec audit resource has no special matchers. For a full list of
available matchers, please visit our [Universal Matchers
page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use
`should_not` if you expect zero matches.

    describe azurerm_management_groups(name: 'my-mg') do
      it { should exist }
    end


## Azure Permissions

Your [Service
Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal)
must be setup with a `Contributor` or `Management Group Contributor` role on the Tenant Root Group or the specific management group(s) you wish to test.
