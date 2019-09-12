The registry_key resource has the following actions:

`:create`

:   Default. Create a registry key. If a registry key already exists
    (but does not match), update that registry key to match.

`:create_if_missing`

:   Create a registry key if it does not exist. Also, create a registry
    key value if it does not exist.

`:delete`

:   Delete the specified values for a registry key.

`:delete_key`

:   Delete the specified registry key and all of its subkeys. The
    `:delete_key` action with the `recursive` attribute will delete the
    registry key, all of its values and all of the names, types, and
    data associated with them. This cannot be undone by Chef Infra
    Client.

`:nothing`

{{ readFile "layouts/shortcodes/resources_common_actions_nothing.md" | markdownify }}