+++
title = "Create a skill assembly"

[menu.cloud]
title = "Create a skill assembly"
identifier = "chef_cloud/360/get_started/skill assembly"
parent = "chef_cloud/360/get_started"
weight = 70
+++

A skill assembly defines a set of skills should be installed or removed from nodes using add and remove rules.

## Prerequisites

- [Skills are defined]({{< relref "define_skills" >}}).

## Create a skill assembly

To create a skill assembly, follow these steps:

{{< readfile file="content/360/saas/reusable_text/md/skill_assembly_get_started.md" >}}

## Troubleshooting

Use the `assembly find-one-assembly` subcommand to verify that the skill assembly was created or updated successfully:

```sh
chef-node-management-cli management assembly find-one-assembly --skillAssemblyId <SKILL_ASSEMBLY_ID> --profile <NODE_MANAGER_PROFILE_NAME>
```

## Next steps

- [Create override settings]({{< relref "override_settings.md" >}}) that define required skill settings.
