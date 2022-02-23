1. On one front-end Chef Infra Server node, follow the [standalone upgrade process](https://docs.chef.io/server/upgrades/#standalone-server).
2. Copy `/var/opt/opscode/upgrades/migration-level` from the first upgraded front-end Chef Infra Server node to `/var/opt/opscode/upgrades/migration-level` on each of the remaining front-end nodes.
3. After copying the updated file to each front-end Chef Infra Server node, repeat the [standalone upgrade process](https://docs.chef.io/server/upgrades/#standalone-server) on each of them.
