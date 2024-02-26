+++
title = "azure_subscriptions Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_subscriptions"
identifier = "inspec/resources/azure/azure_subscriptions Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_subscriptions` InSpec audit resource to test the properties and configuration of all Azure subscriptions for a tenant.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_subscriptions` resource block returns all subscriptions for a tenant.

```ruby
describe azure_subscriptions do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the subscription IDs.

: **Field**: `id`

`names`
: A list of display names of all the subscriptions.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the subscriptions.

: **Field**: `tags`

`tenant_ids`
: A list of tenant IDs of all the subscriptions.

: **Field**: `tenant_id`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check a specific subscription is present

```ruby
describe azure_subscriptions do
  its('names')  { should include 'my-subscription' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_subscriptions do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
