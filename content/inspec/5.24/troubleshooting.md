+++
title = "Chef InSpec Troubleshooting"
draft = false

[menu.inspec_5_24]
    title = "Troubleshooting"
    identifier = "Troubleshooting"
    weight = 70
+++

## Exit code 5

You tried to execute a function with a signed profile, but the signature is either bad or InSpec couldn't find the validation key.
For more information, see the [profile signing documentation](/inspec/5.24/profiles/signing/).

## Undefined Local Variable or Method Error for Cloud Resource

This error is a result of invoking a resource from one of the cloud resource packs without initializing an InSpec profile with that resource pack (AWS, Azure, or GCP) as a dependency.

Chef InSpec profiles that use **any cloud resource** must have the resource pack defined as a dependency.

See the relevant resource pack readme for instructions:

- [inspec-aws README](https://github.com/inspec/inspec-aws#use-the-resources)
- [inspec-azure README](https://github.com/inspec/inspec-azure#use-the-resources)
- [inspec-gcp README](https://github.com/inspec/inspec-gcp#use-the-resources)
