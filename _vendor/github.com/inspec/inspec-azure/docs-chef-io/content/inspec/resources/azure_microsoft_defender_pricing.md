+++
title = "azure_microsoft_defender_pricing Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_microsoft_defender_pricing"
identifier = "inspec/resources/azure/azure_microsoft_defender_pricing Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_microsoft_defender_pricing` Chef InSpec audit resource to test the properties of a Microsoft Defender for Cloud pricing configuration.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_microsoft_defender_pricing(name: 'DEFENDER_PRICING_NAME') do
  it { should exist }
end
```

## Parameters

`name`
: The name of the resource.

## Properties

`id`
: The ID of the resource.

`name`
: The name of the resource.

`type`
: The resource type.

`properties.deprecated`
: True if the plan is deprecated. If there are replacing plans, they will appear in `replacedBy` property.

`properties.freeTrialRemainingTime`
: The duration left for the subscriptions free trial period - in ISO 8601 format (e.g. P3Y6M4DT12H30M5S).

`properties.pricingTier`
: The pricing tier value. Microsoft Defender for Cloud is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features.

`properties.replacedBy`
: List of plans that replace this plan. This property exists only if this plan is deprecated.

`properties.subPlan`
: The sub-plan selected for a Standard pricing configuration, when more than one sub-plan is available. Each sub-plan enables a set of security features. When not specified, full plan is applied.

See the [Azure documentation on Defender for Cloud pricing configuration](https://learn.microsoft.com/en-us/rest/api/defenderforcloud/pricings/get) for additional information. You may access any attribute in the response with the key names separated by dots (`.`).

## Examples

### Test if a name exists

This resource does not have any examples.

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result.

```ruby
describe azure_microsoft_defender_pricing(name: 'DEFENDER_PRICING_NAME') do
  it { should exist }
end
```

Use `should_not` if you expect zero matches.

```ruby
describe azure_microsoft_defender_pricing(name: 'DEFENDER_PRICING_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal. Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.
