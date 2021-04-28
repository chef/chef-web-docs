Use the `registry_key_exists?` method to find out if a Microsoft Windows
registry key exists at the specified path.

<div class="admonition-note">

<p class="admonition-note-title">Note</p>

<div class="admonition-note-text">

{{ readFile "themes/docs-new/layouts/shortcodes/notes_registry_key_not_if_only_if.md" | markdownify }}



</div>

</div>

The syntax for the `registry_key_exists?` method is as follows:

```ruby
registry_key_exists?(KEY_PATH, ARCHITECTURE)
```

where:

-   `KEY_PATH` is the path to the registry key. The path must include
    the registry hive, which can be specified either as its full name or
    as the 3- or 4-letter abbreviation. For example, both
    `HKLM\SECURITY` and `HKEY_LOCAL_MACHINE\SECURITY` are both valid and
    equivalent. The following hives are valid: `HKEY_LOCAL_MACHINE`,
    `HKLM`, `HKEY_CURRENT_CONFIG`, `HKCC`, `HKEY_CLASSES_ROOT`, `HKCR`,
    `HKEY_USERS`, `HKU`, `HKEY_CURRENT_USER`, and `HKCU`.
-   `ARCHITECTURE` is one of the following values: `:x86_64`, `:i386`,
    or `:machine`. Set to `:i386` to read or write 32-bit registry keys
    on 64-bit machines running Microsoft Windows. Set to`:x86_64` to
    force write to a 64-bit registry location, however Chef Infra Client
    returns an exception if `:x86_64` is used on a 32-bit machine. Set
    to `:machine` to allow Chef Infra Client to allow Chef Infra Client
    to use the appropriate key location based on your node's
    architecture. Default value: `:machine`.

This method will return `true` or `false`. (Any registry key values that
are associated with this registry key are ignored.)
