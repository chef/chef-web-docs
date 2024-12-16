When the `chef install` command is run, Chef Workstation caches any
necessary cookbooks and emits a `Policyfile.lock.json` file that
describes:

- The versions of cookbooks in use
- A hash of cookbook content
- The source for all cookbooks
- Attributes included with the Policyfile

A `Policyfile.lock.json` file is associated with a specific policy
group, which means it's associated with one (or more) nodes that use the same
revision of a given policy.
