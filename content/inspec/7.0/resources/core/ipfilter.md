+++
title = "ipfilter resource"
draft = false

platform = "bsd"

[menu.inspec_7_0]
    title = "ipfilter"
    identifier = "resources/core/ipfilter.md ipfilter resource"
    parent = "resources/core"
+++

Use the `ipfilter` Chef InSpec audit resource to test rules defined for `ipfilter`. The `ipfstat` utility is used to report on packet filter statistics and filter list. `ipfstat -io` is used to view the active filtering rule set for the input and the output side of the kernel IP processing. The rule match is done against the output rules of `ipfstat -io`.

## Availability

### Install

{{< readfile file="content/inspec/7.0/reusable/md/inspec_installation.md" >}}

## Syntax

An `ipfilter` resource block declares tests for rules defined for IP Filter:

```ruby
describe ipfilter do
  it { should have_rule("RULE") }
end
```

where:

- `have_rule('RULE')` tests the active rule for ipfilter. This must match the entire line taken from `'ipfstat -io'`.

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test if there are no restrictions on a loopback interface

```ruby
describe ipfilter do
  it { should have_rule("pass in quick on lo0 all") }
  it { should have_rule("pass out quick on lo0 all") }
end
```

### Test if there are no restrictions on inside LAN interface named xl0 for private network

```ruby
describe ipfilter do
  it { should have_rule("pass in quick on xl0 all") }
  it { should have_rule("pass out quick on xl0 all") }
end
```

### Test if there is a rule allowing FTP traffic on the public interface named dc0

```ruby
describe ipfilter do
  it { should have_rule("pass out quick on dc0 proto tcp from any to any port = ftp flags S/FSRPAU keep state") }
end
```

### Test if there is a rule allowing SSH on the public interface named dc0

```ruby
describe ipfilter do
  it { should have_rule("pass out quick on dc0 proto tcp from any to any port = ssh flags S/FSRPAU keep state") }
end
```

Note that the rule specification must exactly match what's in the output of `'ipfstat -io'`, which depends on how you have built your rules.

## Matchers

{{< readfile file="content/inspec/7.0/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### have_rule

The `have_rule` matcher tests the named rule against the information in the output rule of `'ipfstat -io'`:

```ruby
it { should have_rule("RULE") }
```
