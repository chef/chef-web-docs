+++
title = "alicloud_ram_policies Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_ram_policies"
identifier = "inspec/resources/alicloud/alicloud_ram_policies Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_ram_policies` InSpec audit resource to test properties of a collection of Alicloud RAM Policies.

## Syntax

An `alicloud_ram_policies` resource returns a collection of RAM Policies and allows testing of that collection.

```ruby
describe alicloud_ram_policies do
  its('policy_names') { should include('test-policy-1') }
end
```

## Parameters

`type` _(optional)_

: This resource allows filtering by PolicyType.
  To list only Alicloud managed policies, set `type` to `System`. To list only the customer managed policies in your Alicloud account, set `type` to `Custom`. If type is not supplied, both types of policies are returned.

`only_attached` _(optional)_

: This resource allows filtering by attached entities.
  When `only_attached` is `true`, the returned list contains only the policies that are attached to a RAM user, group, or role. When `only_attached` is `false`, or when the parameter is not included, all policies of the specified type(s) (`System` and/or `Custom`) are returned, whether they are attached to any RAM users, groups, or roles, or not.

`region` _(optional)_

: The Alicloud Region ID - see the [Alicloud documentation on Regions and Zones](https://www.alibabacloud.com/help/doc-detail/40654.htm).  
  If provided, it must be passed as `region: 'value'`.  
  If not provided, the `ALICLOUD_REGION` environment variable will be used.

See also the [Alicloud documentation on RAM Policy](https://partners-intl.aliyun.com/help/doc-detail/93732.htm).

## Properties

`policy_names`
: The policy names.

`default_versions`
: The 'default_version' value of each policy.

`attachment_counts`
: The count of attached entities for each policy.

`attached_groups`
: The list of group names of the groups attached to each policy.

`attached_roles`
: The list of role names of the roles attached to each policy.

`attached_users`
: The list of usernames of the users attached to each policy.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Ensure a policy exists.**

```ruby
describe alicloud_ram_policies do
  its('policy_names') { should include('test-policy-1') }
end
```

**Allow at most 100 RAM Policies on the account.**

```ruby
describe alicloud_ram_policies do
  its('entries.count') { should be <= 100}
end
```

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe alicloud_ram_policies.where( <property>: <value>) do
  it { should exist }
end
```

```ruby
describe alicloud_ram_policies.where( <property>: <value>) do
  it { should_not exist }
end
```

### Alicloud Permissions

Your Principal will need the `ram:ListPolicies` and `ram:ListEntitiesForPolicy` actions with Effect set to Allow.

{{< readfile file="content/inspec/resources/reusable/md/alibaba_access_management_doc.md" >}}
{{< readfile file="content/inspec/resources/reusable/md/alibaba_authentication_ram_api_doc.md" >}}
