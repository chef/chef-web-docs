+++
title = "azure_migrate_assessments Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_migrate_assessments"
identifier = "inspec/resources/azure/azure_migrate_assessments Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_migrate_assessments` InSpec audit resource to test the properties related to all Azure Migrate assessments within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_migrate_assessments` resource block returns all Azure Migrate assessments within a project.

```ruby
describe azure_migrate_assessments(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  #...
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`project_name`
: Azure Migrate assessments project name.

The parameter set that should be provided for a valid query are `resource_group` and `project_name`.

## Properties

`ids`
: Path reference to the assessments.

: **Field**: `id`

`names`
: Unique names for all assessments.

: **Field**: `name`

`types`
: Type of the objects.

: **Field**: `type`

`eTags`
: A list of eTags for all the assessments.

: **Field**: `eTag`

`properties`
: A list of Properties for all the assessments.

: **Field**: `properties`

`azureDiskTypes`
: Storage type selected for the disk of all the assessments.

: **Field**: `azureDiskType`

`azureHybridUseBenefits`
: A HUB discount on windows virtual machines for all the assessments.

: **Field**: `azureHybridUseBenefit`

`azureLocations`
: Target Azure locations for which the machines should be assessed.

: **Field**: `azureLocation`

`azureOfferCodes`
: Offer codes according to which cost estimation is done.

: **Field**: `azureOfferCode`

`azurePricingTiers`
: Pricing tiers for size evaluation.

: **Field**: `azurePricingTier`

`azureStorageRedundancies`
: Storage redundancy types offered by Azure.

: **Field**: `azureStorageRedundancy`

`azureVmFamilies`
: List of azure VM families.

: **Field**: `azureVmFamilies`

`confidenceRatingInPercentages`
: Confidence rating percentages for assessment.

: **Field**: `confidenceRatingInPercentage`

`createdTimestamps`
: Time when this project is created.

: **Field**: `createdTimestamp`

`currencies`
: Currencies to report the prices.

: **Field**: `currency`

`discountPercentages`
: Custom discount percentages to be applied to final costs.

: **Field**: `discountPercentage`

`eaSubscriptionIds`
: Enterprise agreement subscription arm IDs.

: **Field**: `eaSubscriptionId`

`monthlyBandwidthCosts`
: Monthly network cost estimates for the machines.

: **Field**: `monthlyBandwidthCost`

`monthlyComputeCosts`
: Monthly compute cost estimates for the machines.

: **Field**: `monthlyComputeCost`

`monthlyPremiumStorageCosts`
: Monthly premium storage cost estimates for the machines.

: **Field**: `monthlyPremiumStorageCost`

`monthlyStandardSSDStorageCosts`
: Monthly standard SSD storage cost estimates for the machines.

: **Field**: `monthlyStandardSSDStorageCost`

`monthlyStorageCosts`
: Monthly storage cost estimates for the machines.

: **Field**: `monthlyStorageCost`

`numberOfMachines`
: Number of assessed machines part of the assessments.

: **Field**: `numberOfMachines`

`percentiles`
: Percentiles of performance data used to recommend Azure size.

: **Field**: `percentile`

`perfDataEndTimes`
: End times to consider performance data for assessments.

: **Field**: `perfDataEndTime`

`perfDataStartTimes`
: Start times to consider performance data for assessments.

: **Field**: `perfDataStartTime`

`pricesTimestamps`
: Times when the Azure Prices are queried.

: **Field**: `pricesTimestamp`

`reservedInstances`
: Azure reserved instances.

: **Field**: `reservedInstance`

`scalingFactors`
: Scaling factors used over utilization data to add a performance buffer for new machines to be created in Azure.

: **Field**: `scalingFactor`

`sizingCriterions`
: Assessment sizing criteria.

: **Field**: `sizingCriterion`

`stages`
: User configurable setting that describes the status of the assessments.

: **Field**: `stage`

`statuses`
: Whether the assessments have been created and are valid.

: **Field**: `status`

`timeRanges`
: Time ranges of performance data used to recommend a size.

: **Field**: `timeRange`

`updatedTimestamps`
: Times when the project is last updated.

: **Field**: `updatedTimestamp`

`vmUptimes`
: Specify the durations for which the VMs are up in the on-premises environment.

: **Field**: `vmUptime`

Refer to the [Azure Migrate assements documentation](https://docs.microsoft.com/en-us/rest/api/migrate/assessment/assessments/list-by-project) for additional information.

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through migrate assessments by their names

```ruby
azure_migrate_assessments(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME'.names.each do |name|
  describe azure_container_group (resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME', group_name: 'GROUP_NAME', name: name) do
    it { should exist }
  end
end
```

### Test to ensure migrate assessments exist with local redundancy

```ruby
describe azure_migrate_assessments(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME').where(azureStorageRedundancy: 'LocallyRedundant') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Migrate Assessments are present in the project and the resource group.

describe azure_migrate_assessments(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Migrate Assessment in the project and the resource group.

describe azure_migrate_assessments(resource_group: 'RESOURCE_GROUP', project_name: 'PROJECT_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
