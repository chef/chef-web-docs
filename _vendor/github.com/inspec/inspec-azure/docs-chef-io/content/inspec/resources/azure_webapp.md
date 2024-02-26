+++
title = "azure_webapp Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_webapp"
identifier = "inspec/resources/azure/azure_webapp Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_webapp` InSpec audit resource to test the properties and configuration of an Azure webapp.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name` or the `resource_id` are required parameters.

```ruby
describe azure_webapp(resource_group: 'RESOURCE_GROUP', name: 'MY_APP') do
  it { should exist }
end
```

```ruby
describe azure_webapp(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: Name of the webapp to test. `my_webapp`.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}`.

`auth_settings_api_version`
: The endpoint API version for the `auth_settings` property. The latest version will be used unless provided.

`configuration_api_version`
: The endpoint API version for the `configuration` property. The latest version will be used unless provided.

`supported_stacks_api_version`
: The endpoint API version for the `supported_stacks` property. The latest version will be used unless provided.

Either one of the parameter sets can be provided for a valid query along with the optional ones:

- `resource_id`
- `resource_group` and `name`

## Properties

`auth_settings`
: Authentication/Authorization settings of the interrogated app with [these](https://docs.microsoft.com/en-us/rest/api/appservice/webapps/getauthsettings#siteauthsettings) properties.

`configuration`
: Configuration of an app, such as platform version, default documents, virtual applications, always on, and so on. For more see [here](https://docs.microsoft.com/en-us/rest/api/appservice/webapps/getconfiguration#siteconfigresource).

`supported_stacks`
: Available application frameworks and their versions with [these](https://docs.microsoft.com/en-us/rest/api/appservice/provider/getavailablestacks#applicationstackcollection) properties.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/appservice/webapps/get#site) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test that a resource group has the specified Webapp and verify it's authentication settings, platform-specific security token storing is enabled

```ruby
describe azure_webapp(resource_group: 'EXAMPLE', name: 'WEBAPP_NAME') do
  it { should exist }
  its('auth_settings.properties') { should have_attributes(enabled: true ) }
  its('configuration.properties') { should have_attributes(tokenStoreEnabled: true) }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### Test webapp to ensure it's using the latest supported version of .NET

```ruby
describe azure_webapp(resource_group: 'EXAMPLE', name: 'WEBAPP_NAME') do
  it { should be_using_latest('aspnet') }
end
```

### Test webapp to ensure it's using the latest supported version of Python

```ruby
describe azure_webapp(resource_group: 'EXAMPLE', name: 'WEBAPP_NAME') do
  it { should be_using_latest('python') }
end
```

### exists

```ruby
# If we expect a resource to always exist.

describe azure_webapp(resource_group: 'RESOURCE_GROUP', name: 'WEBAPP_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_webapp(resource_group: 'RESOURCE_GROUP', name: 'WEBAPP_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
