+++
title = "azure_streaming_analytics_functions Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_streaming_analytics_functions"
identifier = "inspec/resources/azure/azure_streaming_analytics_functions Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_streaming_analytics_functions` InSpec audit resource to test the properties and configuration of multiple Azure Streaming Analytics functions.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_streaming_analytics_functions` resource block returns all functions under a job.

```ruby
describe azure_streaming_analytics_functions(resource_group: "RESOURCE_GROUP", job_name: "AZURE_STREAMING_JOB_NAME") do
  #...
end
```

## Parameters

`resource_group` _(required)_

: Azure resource group where the targeted resource resides.

`job_name` _(required)_

: Name of the job.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/streamanalytics/) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test that the names should be an array

```ruby
describe azure_streaming_analytics_functions(resource_group: "RESOURCE_GROUP", job_name: "AZURE_STREAMING_JOB_NAME") do
  its('names') { should be_an(Array) }
end

```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result.

```ruby
describe azure_streaming_analytics_functions(resource_group: "RESOURCE_GROUP", job_name: "AZURE_STREAMING_JOB_NAME") do
  it { should exist }
end
```

### not_exists

Use `should_not` if you expect zero matches.

```ruby
describe azure_streaming_analytics_functions(resource_group: "RESOURCE_GROUP", job_name: "AZURE_STREAMING_JOB_NAME") do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
