+++
title = "About kitchen-inspec"
draft = false
gh_repo = "inspec"

[menu]
  [menu.inspec]
    title = "kitchen-inspec"
    identifier = "inspec/reference/plugin_kitchen_inspec.md kitchen-inspec"
    parent = "inspec/reference"
    weight = 110
+++

Use Chef InSpec as a Kitchen verifier with `kitchen-inspec`.

Add the Chef InSpec verifier to the `.kitchen.yml` file:

```YML
verifier:
  name: inspec
```

Use a compliance profile from the Chef Compliance server:

```YML
suites:
  - name: compliance
    run_list:
      - recipe[ssh-hardening::default]
    verifier:
      inspec_tests:
        - compliance://base/ssh
```

and then run the following command:

```bash
inspec automate login https://compliance.test --user admin --insecure --token ''
```

where `--insecure` is required when using self-signed certificates.

`inspec compliance` is a backwards compatible alias for `inspec automate` and works the same way:

```bash
inspec compliance login https://compliance.test --user admin --insecure --token ''
```

Use a compliance profile from the Chef Supermarket:

```YML
suites:
  - name: supermarket
    run_list:
      - recipe[ssh-hardening::default]
    verifier:
      inspec_tests:
        - supermarket://dev-sec/ssh-baseline
```

Use Chef InSpec tests from the local file system:

```YML
suites:
  - name: local
    run_list:
      - recipe[my_cookbook::default]
    verifier:
      inspec_tests:
        - test/integration/default
```

Check out [Detect and correct with Test Kitchen](https://learn.chef.io/modules/detect-correct-kitchen#/)
on Learn Chef Rally for a hands-on look at how to use Test Kitchen to run Chef
InSpec profiles.
