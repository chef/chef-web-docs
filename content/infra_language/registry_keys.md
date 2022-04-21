+++
title = "Chef Infra Language: Reading Registry Keys"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Reading Registry Keys"
    identifier = "chef_infra/infra_language/registry_key.md Reading Registry Keys"
    parent = "chef_infra/infra_language"
+++

{{% infra_lang_method_windows_methods %}}

{{< note >}}

The recommended order in which registry key-specific methods should be
used within a recipe is: `key_exists?`, `value_exists?`, `data_exists?`,
`get_values`, `has_subkeys?`, and then `get_subkeys`.

{{< /note >}}

## registry_data_exists?

{{% infra_lang_method_registry_data_exists %}}

## registry_get_subkeys

{{% infra_lang_method_registry_get_subkeys %}}

## registry_get_values

{{% infra_lang_method_registry_get_values %}}

## registry_has_subkeys?

{{% infra_lang_method_registry_has_subkeys %}}

## registry_key_exists?

{{% infra_lang_method_registry_key_exists %}}

## registry_value_exists?

{{% infra_lang_method_registry_value_exists %}}
