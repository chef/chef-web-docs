+++
title = "azure_event_hub_authorization_rule Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_event_hub_authorization_rule"
identifier = "inspec/resources/azure/azure_event_hub_authorization_rule Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_event_hub_authorization_rule` InSpec audit resource to test properties and configuration of an Azure Event Hub Authorization Rule within a Resource Group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group`, `namespace_name`, `event_hub_endpoint` and `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_event_hub_authorization_rule(resource_group: 'my-rg', namespace_name: 'my-event-hub-ns', event_hub_endpoint: 'myeventhub', name: 'my-auth-rule') do
  it { should exist }
end
```
```ruby
describe azure_event_hub_authorization_rule(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `resource-group-name`.

`namespace_name`
: The unique name of the Event Hub Namespace.

`event_hub_endpoint`
: The unique name of the Event Hub Name.

`name`
: The unique name of the targeted resource. `resource-name`.

`authorization_rule`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group`, `namespace_name`, `event_hub_endpoint` and `name`
- `resource_group`, `namespace_name`, `event_hub_endpoint` and `authorization_rule`

## Properties

`properties.rights`
: The list of rights associated with the rule.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/eventhub/2017-04-01/authorization%20rules%20-%20event%20hubs/getauthorizationrule) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test the Name of an Authorization Rule.**

```ruby
describe azure_event_hub_authorization_rule(resource_group: 'my-rg', namespace_name: 'my-event-hub-ns', event_hub_endpoint: 'myeventhub', name: 'my-auth-rule') do
  its('name') { should cmp 'my-auth-rule' }
end
```
```ruby
describe azure_event_hub_authorization_rule(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}') do
  its('name') { should cmp 'my-auth-rule' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect the resource to always exist

describe azure_event_hub_authorization_rule(resource_group: 'my-rg', namespace_name: 'my-event-hub-ns', event_hub_endpoint: 'myeventhub', name: 'my-auth-rule') do
  it { should exist }
end

# If we expect the resource not to exist

describe azure_event_hub_authorization_rule(resource_group: 'my-rg', namespace_name: 'my-event-hub-ns', event_hub_endpoint: 'myeventhub', name: 'my-auth-rule') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
