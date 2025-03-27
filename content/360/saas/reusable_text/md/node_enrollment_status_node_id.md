You can get the node enrollment level of a node using the node ID and the `management node find-one-node` subcommand:

```sh
chef-node-management-cli management node find-one-node --nodeId <NODE_ID> --profile <NODE_MANAGER_PROFILE_NAME>
```

Once a node is successfully enrolled, the enrollment level is set to `enrolled`, otherwise it remains at `admitted`.

```json
"enrollmentLevel": "enrolled"
```

You can also check the enrollment status for the individual steps:

```sh
chef-node-management-cli status get-status --nodeId <NODE_ID> --profile <NODE_MANAGER_PROFILE_NAME>
```

Each step should have a `success` status.

```json
"status": "Success"
```
