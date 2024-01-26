+++
title = "azure_service_bus_subscription_rule Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_service_bus_subscription_rule"
identifier = "inspec/resources/azure/azure_service_bus_subscription_rule Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_service_bus_subscription_rule` InSpec audit resource to test the properties related to an Azure Service Bus subscription rule.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_service_bus_subscription_rule(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', subscription_name: "SUBSCRIPTION_NAME", topic_name: 'TOPIC_NAME', name: 'SUBSCRIPTION_RULE_NAME') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.ServiceBus/Namespaces/Topics/Subscriptions/Rules' }
  its('properties.filterType')            { should eq 'SqlFilter' }
end
```

## Parameters

`name` _(required)_
: Name of the Azure Service Bus subscription rule to test.

`namespace_name` _(required)_
: The namespace name.

`subscription_name` _(required)_
: The subscription name.

`topic_name` _(required)_
: The topic name.

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

## Properties

`id`
: Resource ID.

`name`
: Resource name.

`type`
: Resource type.

`properties`
: The properties of the Service Bus subscription rule.

`properties.action`
: Represents the filter actions that are allowed for the transformation of a message that has been matched by a filter expression.

`properties.filterType`
: Filter type that is evaluated against a BrokeredMessage.

`properties.sqlFilter`
: Properties of sqlFilter.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/servicebus/stable/rules/get) for other properties available.

## Examples

### Test that the Service Bus subscription rule is of SQL Filter type

```ruby
describe azure_service_bus_subscription_rule(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', subscription_name: "SUBSCRIPTION_NAME", topic_name: 'TOPIC_NAME', name: 'SUBSCRIPTION_RULE_NAME') do
  its('properties.filterType') { should eq 'SqlFilter' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a Service Bus subscription rule is found, it will exist.

describe azure_service_bus_subscription_rule(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', subscription_name: "SUBSCRIPTION_NAME", topic_name: 'TOPIC_NAME', name: 'SUBSCRIPTION_RULE_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If a Service Bus subscription rule is not found, it will not exist.

describe azure_service_bus_subscription_rule(resource_group: 'RESOURCE_GROUP', namespace_name: 'NAMESPACE_NAME', subscription_name: "SUBSCRIPTION_NAME", topic_name: 'TOPIC_NAME', name: 'SUBSCRIPTION_RULE_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
