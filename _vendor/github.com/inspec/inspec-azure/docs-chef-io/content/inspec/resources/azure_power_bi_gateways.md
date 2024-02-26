+++
title = "azure_power_bi_gateways Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_power_bi_gateways"
identifier = "inspec/resources/azure/azure_power_bi_gateways Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_power_bi_gateways` InSpec audit resource to test the properties related to all Azure Power BI gateways.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_power_bi_gateways` resource block returns all Azure Power BI gateways.

```ruby
describe azure_power_bi_gateways do
  #...
end
```

## Properties

`ids`
: List of all gateway IDs.

: **Field**: `id`

`names`
: List of all the gateway names.

: **Field**: `name`

`types`
: List of all the gateway types.

: **Field**: `type`

`exponents`
: List of all public key exponents.

: **Field**: `exponent`

`modulus`
: List of all public key modulus.

: **Field**: `modulus`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}
Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/power-bi/Gateways/get-Gateways) for other available properties.

## Examples

### Loop through Power BI gateways by their IDs

```ruby
azure_power_bi_gateways.ids.each do |id|
  describe azure_power_bi_gateway(gateway_id: id) do
    it { should exist }
  end
end
```

### Test to ensure all Power BI gateways exponent is 'AQAB'

```ruby
describe azure_power_bi_gateways.where(exponent: 'AQAB') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Power BI gateways are present.

describe azure_power_bi_gateways do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Power BI gateway.

describe azure_power_bi_gateways do
  it { should exist }
end
```

## Azure Permissions

Your [Service Principal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal) must be set up with a `Dataset.Read.All` role on the Azure Power BI Workspace you wish to test.
