+++
title = "azure_policy_exemptions Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_policy_exemptions"
identifier = "inspec/resources/azure/azure_policy_exemptions Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_policy_exemptions` InSpec audit resource to test properties related to all Azure Policy Exemptions for the subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_policy_exemptions` resource block returns all Azure Policy Exemptions within a Subscription.
```ruby
describe azure_policy_exemptions do
  #...
end
```

## Parameters

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`names`
: A list of names for all the Resources.

: **Field**: `name`

`types`
: A list of types for all the resources.

: **Field**: `type`

`properties`
: A list of Properties all the resources.

: **Field**: `properties`

`system_data`
: A list of System Data for all the resources.

: **Field**: `system_data`

`policy_assignment_ids`
: A list of Policy Assignment IDs.

: **Field**: `policy_assignment_id`

`policy_definition_reference_ids`
: A list of Policy Definition Reference Ids.

: **Field**: `policy_definition_reference_ids`

`exemption_categories`
: A list of categories of Exemptions.

: **Field**: `exemption_category`

`display_names`
: A list of display names of the Exemptions.

: **Field**: `display_name`

`descriptions`
: A list of descriptions of the Exemptions. .

: **Field**: `description`

`metadata`
: A list of metadata info of the Exemptions.

: **Field**: `metadata`

`created_by`
: A list of creators of the exemptions.

: **Field**: `created_by`

`created_by_types`
: A list of type of creators of the exemptions.

: **Field**: `created_by_type`

`created_at`
: A list of created_at timestamps of the exemptions.

: **Field**: `created_at`

`last_modified_by`
: A list of last modifiers of the exemptions.

: **Field**: `last_modified_by`

`last_modified_by_types`
: A list of type of the modifiers of the exemptions.

: **Field**: `last_modified_by_type`

`last_modified_at`
: A list of modified_at timestamps of the exemptions.

: **Field**: `last_modified_at`


{{% inspec_filter_table %}}

## Examples

**Loop through Policy Exemptions by Their Names.**

```ruby
azure_policy_exemptions.names.each do |name|
  describe azure_policy_exemption(name: name) do
    it { should exist }
  end
end  
```     
**Test that There are Policy Exemptions that are of waiver exemption category .**

```ruby
describe azure_policy_exemptions.where(exemption_category: 'Waiver') do
  it { should exist }
end
```    

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no policy exemptions are present in the subscription

describe azure_policy_exemptions do
  it { should_not exist }
end

# Should exist if the filter returns at least one policy exemption in the subscription

describe azure_policy_exemptions do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
