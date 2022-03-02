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

Use the `azure_streaming_analytics_function` InSpec audit resource to test properties and configuration of an Azure streaming analytics function.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group`,`job_name/name` and `function_name`  are required parameters.

```ruby
describe azure_streaming_analytics_function(resource_group: 'RESOURCE_GROUP', job_name: 'JOB_NAME', function_name: 'FUNCTION_NAME') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in.

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



For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/streamanalytics/) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`), eg. `properties.<attribute>`.

## Examples

**Test that a Resource Group has the Specified type.**

```ruby
describe azure_streaming_analytics_function(resource_group: 'RESOURCE_GROUP', job_name: 'JOB_NAME', function_name: 'FUNCTION_NAME') do
  it { should exist }
  its('type')                                         { should cmp 'Microsoft.StreamAnalytics/streamingjobs/functions' }
  its('properties.type')                              { should cmp 'Scalar' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### Test Streaming function to ensure it's using Javascript UDF

```ruby
describe azure_streaming_analytics_function(resource_group: 'RESOURCE_GROUP', job_name: 'JOB_NAME', function_name: 'FUNCTION_NAME') do
  its('properties.binding.type')                              { should cmp 'Microsoft.StreamAnalytics/JavascriptUdf' }
end
```

### exists

If we expect a resource to always exist:

```ruby
describe azure_streaming_analytics_function(resource_group: 'RESOURCE_GROUP', job_name: 'JOB_NAME', function_name: 'FUNCTION_NAME') do
  it { should exist }
end
```

If we expect a resource to never exist:

```ruby
describe azure_streaming_analytics_function(resource_group: 'RESOURCE_GROUP', job_name: 'JOB_NAME', function_name: 'FUNCTION_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
