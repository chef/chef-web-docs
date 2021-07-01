{{< note >}}
Chef Infra Server versions earlier than 14.5 configured with `nginx['enable_non_ssl'] = false` and `fips = true` require `export CSC_LB_URL=https://127.0.0.1` to run the command `chef-server-ctl reindex <options>`
{{< /note >}}