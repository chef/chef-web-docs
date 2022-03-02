+++
title = "azure_active_directory_objects Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_active_directory_objects"
identifier = "inspec/resources/azure/azure_active_directory_objects Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_active_directory_objects` InSpec audit resource to test properties and configuration of multiple Azure Active Directory Objects.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_active_directory_objects` resource block returns all Active Directory Objects for the current service principle.
```ruby
describe azure_active_directory_objects do
  #...
end
```

## Parameters

This resource does not require any parameters.

## Properties

`values`
: A list of the unique directory object values.

: **Field**: `value`

{{% inspec_filter_table %}}

## Examples

**Iterate over and test the visibility of Active Directory objects.**

```ruby
  azure_active_directory_objects.values.each do |value|
    describe azure_active_directory_object(id: value)  do
      it { should exist }
      its('visibility') { should_not be_empty }
    end
  end

```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
# If we expect current service principle to have AD objects

describe azure_active_directory_objects do
  it { should exist }
end

# If we expect current service principle to not have AD objects

describe azure_active_directory_objects do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
