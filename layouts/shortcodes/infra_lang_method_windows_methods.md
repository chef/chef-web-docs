Six methods are present in the Chef Infra Language to help verify the registry
during a Chef Infra Client run on the Windows
platform---`registry_data_exists?`, `registry_get_subkeys`,
`registry_get_values`, `registry_has_subkeys?`, `registry_key_exists?`,
and `registry_value_exists?`---these helpers ensure the
**powershell_script** resource is idempotent.
