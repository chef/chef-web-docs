+++
title = "alicloud_ram_policy Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_ram_policy"
identifier = "inspec/resources/alicloud/alicloud_ram_policy Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_ram_policy` InSpec audit resource to test properties of a single managed Alicloud RAM Policy.

## Syntax

An `alicloud_ram_policy` resource block identifies a policy by policy name.

    # Find a policy by name
```ruby
describe alicloud_ram_policy(policy_name: 'AliyunSupportFullAccess') do
  it { should exist }
end
```

## Parameters

This resource requires the `policy_name` to be provided.

`policy_name` _(required)_

: The Policy Name which uniquely identifies the Policy.  
  It can be passed as a string if it is the only parameter, or using hash syntax, `policy_name: 'value'`.

`type` _(optional)_

: The type of policy: 'System' or 'Custom'.  
  If provided, it must be passed as `type: 'value'` .  
  If not provided, both types of policies will be searched.

`region` _(optional)_

: The Alicloud Region ID - see the [Alicloud documentation on Regions and Zones](https://www.alibabacloud.com/help/doc-detail/40654.htm).  
  If provided, it must be passed as `region: 'value'`.  
  If not provided, the `ALICLOUD_REGION` environment variable will be used.

See also the [Alicloud documentation on RAM Policy](https://partners-intl.aliyun.com/help/doc-detail/93732.htm).

## Properties

`policy_name`
: The name of the specified policy.

`attachment_count`
: The count of attached entities for the specified policy.

`attached_groups`
: The list of group names of the groups attached to the policy.

`attached_group_count`
: The count of attached groups for the specified policy.

`attached_roles`
: The list of ARNs of the roles attached to the policy.

`attached_role_count`
: The count of attached roles for the specified policy.

`attached_users`
: The list of usernames of the users attached to the policy.

`attached_user_count`
: The count of attached users for the specified policy.

`default_version`
: The default version value of the specified policy.

`policy_document`
: Returns the default version of the policy document after decoding as a Ruby hash. This hash contains the policy statements and is useful for performing checks that cannot be expressed using higher-level matchers like `have_statement`.

`statement_count`
: Returns the number of statements present in the `policy`.

## Examples

**Test that a policy does exist.**

```ruby
describe alicloud_ram_policy(policy_name: 'AliyunSupportFullAccess', type: 'System') do
  it { should exist }
end
```

**Test that a policy is attached to at least one entity.**

```ruby
describe alicloud_ram_policy(policy_name: 'AliyunSupportFullAccess') do
  it { should be_attached }
end
```

**Examine the policy statements.**

```ruby
describe alicloud_ram_policy(policy_name: 'my-policy', type: 'Custom') do
**Verify that there is at least one statement allowing access to OSS.**

  it { should have_statement(Action: 'oss:PutObject', Effect: 'allow') }
```

```ruby
**have_statement does not expand wildcards. If you want to verify.**
**they are absent, an explicit check is required.**

it { should_not have_statement(Action: 'oss:*') }
```

```ruby
**You can also check NotAction.**

it { should_not have_statement(NotAction: 'ram:*') }
```

```ruby
**Check number of statements in policy.**

its('statement_count') { should be > 1 }
    end
```

**Examine attached users, groups and roles.**

```ruby
describe alicloud_ram_policy(policy_name: 'my-policy') do
  it { should be_attached_to_user('user-1') }
  its{'attached_users') { should include 'user-1' }
```

```ruby
it { should be_attached_to_group('group-1') }
its{'attached_groups') { should include 'group-1' }
```

```ruby
it { should be_attached_to_role('acs:ram::12345:role/role-1') }
its{'attached_roles') { should include 'acs:ram::12345:role/role-1' }
```

```ruby
its('attached_user_count') { should eq 5 }
its('attached_group_count') { should eq 1 }
its('attached_role_count') { should be > 0 }
its('attachment_count') { should be eq 7 }
    end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
it { should exist }
```

```ruby
it { should_not exist }
```

#### be_attached

The test will pass if the identified policy is attached to at least one RAM user, group, or role.

```ruby
describe alicloud_ram_policy(policy_name: 'AliyunSupportFullAccess') do
  it { should be_attached }
end
```

#### be_attached_to_group(GROUPNAME)

The test will pass if the identified policy is attached to the specified group.

```ruby
describe alicloud_ram_policy(policy_name: 'AliyunSupportFullAccess') do
  it { should be_attached_to_group(GROUPNAME) }
end
```

#### be_attached_to_user(USERNAME)

The test will pass if the identified policy is attached to the specified user.

```ruby
describe alicloud_ram_policy(policy_name: 'AliyunSupportFullAccess') do
  it { should be_attached_to_user(USERNAME) }
end
```

#### be_attached_to_role(ROLEARN)

The test will pass if the identified policy is attached to the specified role ARN.

```ruby
describe alicloud_ram_policy(policy_name: 'AliyunSupportFullAccess') do
  it { should be_attached_to_role(ROLEARN) }
end
```

#### have_statement

Examines the list of statements contained in the policy and passes if at least one of the statements matches. This matcher does _not_ interpret the policy in a request authorization context, as Alicloud does when a request processed. Rather, `have_statement` examines the literal contents of the RAM policy, and reports on what is present (or absent, when used with `should_not`).

`have_statement` accepts the following criteria to search for matching statements. If any statement matches all the criteria, the test is successful.  All keys in criteria may be used as Titlecase or lowercase, string or symbol. Values must be in the expected case.

* `Action` - Expresses the requested operation. Acceptable literal values are any Alicloud operation name, including the '*' wildcard character. `Action` may also use a list of Alicloud operation names.
* `Effect` - Expresses if the operation is permitted. Acceptable values are 'Deny' and 'Allow'.
* `Sid` - A user-provided string identifier for the statement.
* `Resource` - Expresses the operation's target. Acceptable values are ARNs, including the '*' wildcard. `Resource` may also use a list of ARN values.

Please note the following about the behavior of `have_statement`:
* `Action`, `Sid`, and `Resource` allow using a regular expression as the search critera instead of a string literal.
* It does not support wildcard expansion; to check for a wildcard value, check for it explicitly. For example, if the policy includes a statement with `"Action": "oss:*"` and the test checks for `Action: "oss:PutObject"`, the test _will not match_. You must write an additional test checking for the wildcard case.
* It supports searching list values. For example, if a statement contains a list of 3 resources, and a `have_statement` test specifes _one_ of those resources, it will match.
* `Action` and `Resource` allow using a list of string literals or regular expressions in a test, in which case _all_ must match on the _same_ statement for the test to match. Order is ignored.
* It does not support the Principal or Condition policy elements.

Examples:

    # Verify there is no full-admin statement
```ruby
describe alicloud_ram_policy(policy_name: 'kryptonite') do
  it { should_not have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => '*')}
end
```

    # Symbols and lowercase also allowed as criteria
```ruby
describe alicloud_ram_policy(policy_name: 'kryptonite') do
  # All 4 the same
  it { should_not have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => '*')}
  it { should_not have_statement('effect' => 'Allow', 'resource' => '*', 'action' => '*')}
  it { should_not have_statement(Effect: 'Allow', Resource: '*', Action: '*')}
  it { should_not have_statement(effect: 'Allow', resource: '*', action: '*')}
end
```

    # Verify bob is allowed to manage things on OSS buckets that start with bobs-stuff
```ruby
describe alicloud_ram_policy(policy_name: 'bob-is-a-packrat') do
  it { should have_statement(Effect: 'Allow',
                             # Using the Alicloud wildcard - this must match exactly
                             Resource: 'acs:oss:::bobs-stuff*',
                             # Specify a list of actions - all must match, no others, order isn't important
                             Action: ['oss:PutObject', 'oss:GetObject', 'oss:DeleteObject'])}
```

```ruby
# Bob would make new buckets constantly if we let him.
it { should_not have_statement(Effect: 'Allow', Action: 'oss:CreateBucket')}
it { should_not have_statement(Effect: 'Allow', Action: 'oss:*')}
it { should_not have_statement(Effect: 'Allow', Action: '*')}
```

```ruby
# An alternative to checking for wildcards is to specify the
# statements you expect, then restrict statement count
its('statement_count') { should cmp 1 }
    end
```

    # Use regular expressions to examine the policy
```ruby
describe alicloud_ram_policy(policy_name: 'regex-demo') do
  # Check to see if anything mentions RDS at all.
  # This catches `rds:CreateDBinstance` and `rds:*`, but would not catch '*'.
  it { should_not have_statement(Action: /^rds:.+$/)}
```

```ruby
# This policy should refer to both sally and kim's OSS buckets.
# This will only match if there is a statement that refers to both resources.
it { should have_statement(Resource: [/acs:oss.+:sally/, /acs:oss.+:kim/]) }
# The following also matches on a statement mentioning only one of them
it { should have_statement(Resource: /acs:oss.+:(sally|kim)/) }
    end
```

### Alicloud Permissions

Your Principal will need the `ram:GetPolicy` and `ram:ListEntitiesForPolicy` actions with Effect set to Allow.

See the [Alibaba Cloud Resource Access Management documentation](https://www.alibabacloud.com/help/doc-detail/57445.htm?spm=a2c63.p38356.b99.12.51ef1b28W18VZd) and
[documentation on authentication to RAM APIs](https://partners-intl.aliyun.com/help/doc-detail/102666.htm).
