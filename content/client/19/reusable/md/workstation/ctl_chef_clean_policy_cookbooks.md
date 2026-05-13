Use the `chef clean-policy-cookbooks` subcommand to delete cookbooks
that aren't used by Policyfile files. Cookbooks are considered unused
when they aren't referenced by any policy revisions on the Chef Infra
Server.

{{< note >}}

Cookbooks that are referenced by orphaned policy revisions aren't
removed. Use `chef clean-policy-revisions` to remove orphaned policies.

{{< /note >}}
