+++
title = "Configure origin membership and role-based access control"

[menu]
  [menu.habitat]
    title = "Origin membership and RBAC"
    identifier = "habitat/on-prem-builder/origins/rbac"
    parent = "habitat/on-prem-builder/origins"
    weight = 50
+++

You can use role-based access control (RBAC) to assign specific levels of access to each user that belongs to an origin.

When you join an origin, Chef Habitat Builder assigns you the _read-only_ role, and when you create an origin, it assigns you the _owner_ role. These roles are linked to your personal access token. An owner or administrator can update a user's role.

## Prerequisites

- [Download and install the Chef Habitat CLI](/habitat/install_habitat/)
- A Chef Habitat On-Prem Builder account
- A personal access token for On-Prem Builder
- [Create an origin](../create_an_origin) or accept an invitation to an existing origin
- [Get origin keys](../origin_keys)

## Origin roles

Chef Habitat Builder has the following origin roles and permissions:

Read-Only

- Can view packages, channels, origin membership, invitations, member roles, settings, and integrations.
- Can't upload, promote, or modify packages, channels, keys, settings, or integrations.
- Can't manage origin membership, roles, or secrets.

Member

- Inherits all Read-Only permissions.
- Can upload packages to the unstable channel and trigger build jobs in unstable.
- Can't promote packages or modify channels, keys, settings, or integrations.
- Can't manage origin membership, roles, or secrets.

Maintainer

- Inherits all Member permissions.
- Can promote packages, add/update/delete channels, and manage integrations.
- Can't manage origin keys, membership roles, or secrets.

Administrator

- Inherits all Maintainer permissions.
- Can manage origin keys, membership roles, and secrets.
- Can't transfer or delete the origin.

Owner

- Has full permissions, including the ability to transfer or delete the origin.
- Can perform all actions available to Administrators and more.

Also, see the following table of role permissions:

| Action                           | Read-Only | Member | Maintainer | Administrator | Owner |
| -------------------------------- | --------- | ------ | ---------- | ------------- | ----- |
| **Packages**                     |           |        |            |               |       |
| View packages                    | Y         | Y      | Y          | Y             | Y     |
| Upload packages to `unstable`    | N         | Y      | Y          | Y             | Y     |
| Promote packages from `unstable` | N         | N      | Y          | Y             | Y     |
| **Channels**                     |           |        |            |               |       |
| View channels                    | Y         | Y      | Y          | Y             | Y     |
| Add/Update/Delete channels       | N         | N      | Y          | Y             | Y     |
| **Origin Keys**                  |           |        |            |               |       |
| View keys                        | Y         | Y      | Y          | Y             | Y     |
| Add/Update/Delete keys           | N         | N      | N          | Y             | Y     |
| **Origin Membership**            |           |        |            |               |       |
| View origin membership           | Y         | Y      | Y          | Y             | Y     |
| View invitations                 | Y         | Y      | Y          | Y             | Y     |
| Send Invitations                 | N         | N      | Y          | Y             | Y     |
| Revoke Invitations               | N         | N      | Y          | Y             | Y     |
| **Member Roles**                 |           |        |            |               |       |
| View member roles                | Y         | Y      | Y          | Y             | Y     |
| Update member roles              | N         | N      | N          | Y             | Y     |
| **Origin Settings**              |           |        |            |               |       |
| View settings                    | Y         | Y      | Y          | Y             | Y     |
| Add/Update/Delete settings       | N         | N      | N          | Y             | Y     |
| **Origin Secrets**               |           |        |            |               |       |
| View secrets                     | N         | N      | N          | Y             | Y     |
| Add/Update/Delete secrets        | N         | N      | N          | Y             | Y     |
| **Cloud Integrations**           |           |        |            |               |       |
| View integrations                | Y         | Y      | Y          | Y             | Y     |
| Add/Update/Delete integrations   | N         | N      | Y          | Y             | Y     |
| **Ownership**                    |           |        |            |               |       |
| Transfer origin                  | N         | N      | N          | N             | Y     |
| Delete origin                    | N         | N      | N          | N             | Y     |

### Manage origin members

You can use the `hab` CLI to manage and view users' roles in an origin. You can also view users' roles and invite users in Habitat Builder.

#### Invite members

Manage Chef Habitat Builder origin membership with the Chef Habitat CLI, using the [`hab origin invitations`](/habitat/habitat_cli/#hab-origin-invitations) command.

All Chef Habitat Builder users can accept, ignore, and see invitations for their accounts.

View origin invitations:

```bash
hab origin invitations list
```

Accept origin invitations:

```bash
hab origin invitations accept <ORIGIN> <INVITATION_ID>
```

Ignore origin invitations:

```bash
hab origin invitations ignore <ORIGIN> <INVITATION_ID>
```

Send origin membership invitations:

```bash
hab origin invitations send <ORIGIN> <INVITEE_ACCOUNT>
```

Origin administrators and owners can see all pending origin membership invitations:

```bash
hab origin invitations pending <ORIGIN>
```

Origin administrators and owners can rescind an origin membership invitation:

```bash
hab origin invitations rescind <ORIGIN> <INVITATION_ID>
```

### Transfer origin ownership

Origin owners can transfer origin ownership to another member with the [`hab origin transfer` subcommand](/habitat/habitat_cli/#hab-origin-transfer):

```bash
hab origin transfer [OPTIONS] <ORIGIN> <NEW_OWNER_ACCOUNT>
```

#### Manage membership roles

You can see and set a member's role using the `hab origin rbac` CLI subcommands.
You can also see the list of origin members in an origin's **Members** tab.

The [`hab origin rbac`](/habitat/habitat_cli/#hab-origin-rbac) command syntax is:

```bash
hab origin rbac <SUBCOMMAND>
```

The syntax for the `show` subcommand is:

```bash
hab origin rbac show <MEMBER_ACCOUNT> --origin <ORIGIN>
```

The syntax for the `set` subcommand is:

```bash
hab origin rbac set [FLAGS] [OPTIONS] <MEMBER_ACCOUNT> <ROLE> --origin <ORIGIN>
```
