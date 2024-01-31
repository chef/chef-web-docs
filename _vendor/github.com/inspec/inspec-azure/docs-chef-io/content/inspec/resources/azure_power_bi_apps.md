+++
title = "azure_power_bi_apps Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_apps"
identifier = "inspec/resources/azure/azure_power_bi_apps Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_apps` InSpec audit resource to test the properties related to all Azure Power BI apps.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_power_bi_apps` resource block returns all Azure Power BI apps.

```ruby
describe azure_power_bi_apps do
  #...
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: List of all app IDs.

: **Field**: `id`

`names`
: List of all the app names.

: **Field**: `name`

`descriptions`
: List of all the app Descriptions.

: **Field**: `description`

`lastUpdates`
: List of all Last updated times of the apps.

: **Field**: `lastUpdate`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}
Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/apps/get-apps) for other properties available.

## Examples

### Loop through Power BI apps by their IDs

```ruby
azure_power_bi_apps.ids.each do |id|
  describe azure_power_bi_app(app_id: id) do
    it { should exist }
  end
end
```

### Test that a Power BI app named 'Finance' exists

```ruby
describe azure_power_bi_apps.where(name: 'Finance') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Power BI apps are present.

describe azure_power_bi_apps do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Power BI apps.

describe azure_power_bi_apps do
  it { should exist }
end
```

## Azure Permissions

This API does not support Service Principal Authentication. Use your Active Directory account access tokens to access this resource.
Your Active Directory account must be set up with an `App.Read.All` role on the Azure Power BI workspace you wish to test.
