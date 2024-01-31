+++
title = "azure_power_bi_app Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_app"
identifier = "inspec/resources/azure/azure_power_bi_app Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_app` InSpec audit resource to test the properties related to Azure Power BI apps.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`app_id` is a required parameter.

```ruby
describe azure_power_bi_app(app_id: 'APP_ID') do
  it  { should exist }
end
```

## Parameters

`app_id` _(required)_

: The app ID.

## Properties

`id`
: The app ID.

`name`
: The app name.

`description`
: The app description.

`publishedBy`
: The app publisher.

`lastUpdate`
: The last time the app was updated.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/apps/get-app) for other properties available.

## Examples

### Test that the Power BI app is published by inspec-devs

```ruby
describe azure_power_bi_app(app_id: 'APP_ID')  do
  its('publishedBy') { should eq 'inspec-devs' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If the Azure Power BI app is found, it will exist.

describe azure_power_bi_app(app_id: 'APP_ID')  do
  it { should exist }
end
```

### not_exists

```ruby
# if the Azure Power BI app is not found, it will not exist.

describe azure_power_bi_app(app_id: 'APP_ID')  do
  it { should_not exist }
end
```

## Azure Permissions

This API does not support Service Principal Authentication. Use your Active Directory account access tokens to access this resource.
Your Active Directory account must be set up with an `App.Read.All` role on the Azure Power BI workspace you wish to test.
