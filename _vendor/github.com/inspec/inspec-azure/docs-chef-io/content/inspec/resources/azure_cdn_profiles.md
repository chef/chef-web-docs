+++
title = "azure_cdn_profiles Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_cdn_profiles"
identifier = "inspec/resources/azure/azure_cdn_profiles Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_cdn_profiles` Chef InSpec audit resource to test properties and configuration of Azure CDN profiles.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_cdn_profiles` resource block returns all Azure CDN profiles, either within a resource group (if provided), or within an entire subscription.

```ruby
describe azure_cdn_profiles do
  #...
end
```

or

```ruby
describe azure_cdn_profiles(resource_group: 'RESOURCE_GROUP') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`locations`
: A list of locations for all the resources being interrogated.

: **Field**: `location`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`types`
: A list of the types of resources being interrogated.

: **Field**: `type`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

`skus`
: A list of the SKUs of the resources being interrogated.

: **Field**: `sku`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

**Check that a CDN profile is present.**

````ruby
describe azure_cdn_profiles do
    it            { should exist }
    its('names')  { should include 'CDN_PROFILE' }
end
````

**Filter the CDN profiles by name and verify that it exists.**

```ruby
describe azure_cdn_profiles.where{ name.eql?('CDN_PROFILE_NAME') } do
  it { should exist }
end
```

**Filter the CDN profiles by location and verify that at least one exists.**

```ruby
describe azure_cdn_profiles.where{ location.eql?('eastus-2') } do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control will pass if the filter returns at least one result.

```ruby
describe azure_cdn_profiles(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

Use `should_not` if you expect zero matches.

```ruby
describe azure_cdn_profiles(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
