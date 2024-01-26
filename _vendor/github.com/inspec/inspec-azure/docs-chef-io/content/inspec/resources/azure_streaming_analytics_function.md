+++
title = "azure_streaming_analytics_function Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_streaming_analytics_function"
identifier = "inspec/resources/azure/azure_streaming_analytics_function Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_streaming_analytics_function` InSpec audit resource to test the properties and configuration of an Azure Streaming Analytics function.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group`,`job_name/name`, and `function_name`  are required parameters.

```ruby
describe azure_streaming_analytics_function(resource_group: 'RESOURCE_GROUP', job_name: 'JOB_NAME', function_name: 'FUNCTION_NAME') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`job_name`
: Name of the job.

`function_name`
: Name of the function made in the job mentioned.

All three parameters are required for a valid query.

## Properties

`properties.binding`
: The physical binding of the function. For example, in the Azure Machine Learning web service’s case, this describes the endpoint.

`properties.inputs`
: A list of inputs describing the parameters of the function.

`properties.binding`
: The output of the function.

`etag`
: The current entity tag for the function.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/streamanalytics/) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test that a resource group has the specified type

```ruby
describe azure_streaming_analytics_function(resource_group: 'RESOURCE_GROUP', job_name: 'JOB_NAME', function_name: 'FUNCTION_NAME') do
  it { should exist }
  its('type')                                         { should cmp 'Microsoft.StreamAnalytics/streamingjobs/functions' }
  its('properties.type')                              { should cmp 'Scalar' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### Test streaming function to ensure it's using Javascript UDF

```ruby
describe azure_streaming_analytics_function(resource_group: 'RESOURCE_GROUP', job_name: 'JOB_NAME', function_name: 'FUNCTION_NAME') do
  its('properties.binding.type')                              { should cmp 'Microsoft.StreamAnalytics/JavascriptUdf' }
end
```

### exists

If we expect a resource to always exist.

```ruby
describe azure_streaming_analytics_function(resource_group: 'RESOURCE_GROUP', job_name: 'JOB_NAME', function_name: 'FUNCTION_NAME') do
  it { should exist }
end
```

### not_exists

If we expect a resource to never exist.

```ruby
describe azure_streaming_analytics_function(resource_group: 'RESOURCE_GROUP', job_name: 'JOB_NAME', function_name: 'FUNCTION_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
