+++
title = "azure_synapse_notebooks Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_synapse_notebooks"
identifier = "inspec/resources/azure/azure_synapse_notebooks Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_synapse_notebooks` InSpec audit resource to test the properties related to all Azure Synapse notebooks in a Synapse Analytics workspace.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_synapse_notebooks` resource block returns all Azure Synapse notebooks within a Synapse workspace.

```ruby
describe azure_synapse_notebooks(endpoint: 'WORKSPACE_DEVELOPMENT_ENDPOINT') do
  #...
end
```

## Parameters

This resource requires the `endpoint` parameter for a valid query.

`endpoint`
: The Azure Synapse workspace development endpoint.

## Properties

`ids`
: A list of the unique fully qualified resource IDs.

: **Field**: `id`

`names`
: A list of names for all the Synapse notebooks.

: **Field**: `name`

`types`
: A list of types for all the resources.

: **Field**: `type`

`properties`
: A list of properties for all the notebooks.

: **Field**: `properties`

`etags`
: A list of resource Etags.

: **Field**: `tags`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through Synapse Notebooks by their names

```ruby
azure_synapse_notebooks(endpoint: 'WORKSPACE_DEVELOPMENT_ENDPOINT').names.each do |name|
  describe azure_synapse_notebook(endpoint: 'WORKSPACE_DEVELOPMENT_ENDPOINT', name: name) do
    it { should exist }
  end
end
```

### Test that there are Synapse Notebooks that include a certain string in their names (Client Side Filtering)

```ruby
describe azure_synapse_notebooks(endpoint: 'WORKSPACE_DEVELOPMENT_ENDPOINT').where { name.include?('analytics-trends') } do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if there aren't any Synapse notebooks in the resource group.

describe azure_synapse_notebooks(endpoint: 'WORKSPACE_DEVELOPMENT_ENDPOINT') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one Synapse notebook.

describe azure_synapse_notebooks(endpoint: 'WORKSPACE_DEVELOPMENT_ENDPOINT') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
