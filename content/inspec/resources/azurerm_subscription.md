+++
title = "azurerm_subscription resource"
draft = false

[menu]
  [menu.inspec]
    title = "azurerm_subscription"
    identifier = "inspec/resources/azurerm_subscription.md azurerm_subscription resource"
    parent = "inspec/resources"
+++


Use the `azurerm_subscription` InSpec audit resource to test properties related to the current subscription
subscription.

<br />

## Azure REST API version

This resource interacts with version `2019-10-01` of the Azure
Management API. For more information see the [official Azure documentation](https://docs.microsoft.com/en-us/rest/api/resources/subscriptions/get).

At the moment, there doesn't appear to be a way to select the version of the
Azure API docs. If you notice a newer version being referenced in the official
documentation please open an issue or submit a pull request using the updated
version.

## Availability

### Installation

This resource is available in the `inspec-azure` [resource
pack](https://www.inspec.io/docs/reference/glossary/#resource-pack). To use it, add the
following to your `inspec.yml` in your top-level profile:

    depends:
      - name: inspec-azure
        git: https://github.com/inspec/inspec-azure.git

You'll also need to setup your Azure credentials; see the resource pack
[README](https://github.com/inspec/inspec-azure#inspec-for-azure).

### Version

This resource first became available in 1.7.0 of the inspec-azure resource pack.

## Syntax

The resource will retrieve the current subscription which Inspec is using, which is
specified in your environment/service principal.

    describe azurerm_subscription do
      ...
    end

<br />

## Examples
### Ensure a location is available in a subscription.
    describe azurerm_subscription do
      its('name')      { should eq 'subscription name' }
      its('locations') { should include 'eastus' }
    end

<br />

## Parameters

No parameters required.

## Attributes

  - `id`
  - `name`
  - `locations`

### id

The subscription's unique id. e.g. '1ea4649e-0132-4f1c-8b68-9f9b2147281c'

### name

The subscriptions's display name.

    its('name') { should eq('subscription name') }

### locations

An array of locations available in this subscription.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of
available matchers, please visit our [Universal Matchers
page](https://www.inspec.io/docs/reference/matchers/).

### exists

    describe azurerm_subscription do
      it { should exist }
    end

## Azure Permissions

Your [Service
Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal)
must be setup with a `contributor` role on the subscription you wish to test.
