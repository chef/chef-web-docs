+++
title = "opa_api resource"
draft = false

platform = "os"

[menu.inspec_6_8]
    title = "opa_api"
    identifier = "resources/core/opa_api.md opa_api resource"
    parent = "resources/core"
+++

Use the `opa_api` Chef InSpec audit resource to query Open Policy Agent (OPA) using the OPA URL and data.

## Availability

### Install

{{< readfile file="content/inspec/6.8/reusable/md/inspec_installation.md" >}}

## Syntax

An `opa_api` resource block declares OPA policy configurations that can be tested.

```ruby
describe opa_api(url: "localhost:8181/v1/data/example/violation", data: "input.json") do
  its(["result"]) { should eq 'value' }
end
```

where:

- `'url'` specifies the url of the OPA server on which OPA is running.
- `'data'` specifies the json formatted data or json file.
- `its(["returned_result"]) { should eq 'expected_result' }` compares the results of the query against the expected result in the test.

## parameters

The `opa_api` resource InSpec resource requires a `url` and `data` as a JSON file or a string in JSON format.

### `url` _(required)_

The URL of the OPA API server.

### `data` _(required)_

An OPA query as a JSON data file or a string in JSON format.

## Properties

### result

The `result` property checks whether the resource query returns an empty result.

```ruby
its('result') { should be nil }
```

### allow

The `allow` property checks if a specific input matches the policy defined in OPA. This matcher won't work if `allow` isn't defined in the OPA Rego file.

```ruby
its('allow') { should eq 'value' }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

```ruby
describe opa_api(url: "localhost:8181/v1/data/example/allow", data: "input.json") do
  its("result") { shoule_not be nil }
  its(["result"]) { should eq true }
  its("allow") { should eq "true" }
end
```

The above example shows how the `allow` value can be fetched in two ways.

## Matchers

{{< readfile file="content/inspec/6.8/reusable/md/inspec_matchers_link.md" >}}
