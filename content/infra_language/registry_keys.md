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

{{< readfile file="content/reusable/md/infra_lang_method_windows_methods.md" >}}

{{< note >}}

The recommended order in which registry key-specific methods should be
used within a recipe is: `key_exists?`, `value_exists?`, `data_exists?`,
`get_values`, `has_subkeys?`, and then `get_subkeys`.

{{< /note >}}

## registry_data_exists?

{{< readfile file="content/reusable/md/infra_lang_method_registry_data_exists.md" >}}

{{< note >}}

{{< readfile file="content/reusable/md/notes_registry_key_not_if_only_if.md" >}}

{{< /note >}}

{{< readfile file="content/reusable/md/infra_lang_method_registry_data_exists_syntax.md" >}}

## registry_get_subkeys

{{< readfile file="content/reusable/md/infra_lang_method_registry_get_subkeys.md" >}}

## registry_get_values

{{< readfile file="content/reusable/md/infra_lang_method_registry_get_values.md" >}}

## registry_has_subkeys?

{{< readfile file="content/reusable/md/infra_lang_method_registry_has_subkeys.md" >}}

## registry_key_exists?

{{< readfile file="content/reusable/md/infra_lang_method_registry_key_exists.md" >}}

## registry_value_exists?

{{< readfile file="content/reusable/md/infra_lang_method_registry_value_exists.md" >}}
