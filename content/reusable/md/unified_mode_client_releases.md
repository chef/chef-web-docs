
In Chef Infra Client 17 (April 2021) and some earlier versions, unified mode is not enabled by default. Enable unified mode on a custom resource with `unified_mode true`. Chef Infra Client displays a deprecation message with `unified_mode false`.

In Chef Infra Client 18 (April 2022), `unified_mode true` will become the default behavior.

| Chef Infra Client | Unified Mode                  |
|-------------------|-------------------------------|
| 18.x (2022)       | Default: `unified_mode true`  |
| 17.x (2021)       | Default: `unified_mode false` |
| 16.x (2020)       | Default: `unified_mode false` |
| 15.3 and higher   | Default: `unified_mode false` |
| 15.0-15.2         | Not available                 |
| 14.14-14.15       | Default: `unified_mode false` |
| Lower than 14.14  | Not available                 |
