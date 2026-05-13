Use the `chef undelete` subcommand to recover a deleted policy or policy
group. This command:

- Doesn't detect conflicts. If a deleted item has been recreated,
    running this command will overwrite it
- Doesn't include cookbooks that may be referenced by Policyfiles;
    cookbooks that are cleaned after running this command may not be
    fully restorable to their previous state
- Doesn't store access control data
