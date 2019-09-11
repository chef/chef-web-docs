The registry_key resource has the following properties:

`architecture`

:   **Ruby Type:** Symbol \| **Default Value:** `:machine`

    The architecture of the node for which keys are to be created or
    deleted. Possible values: `:i386` (for nodes with a 32-bit
    registry), `:x86_64` (for nodes with a 64-bit registry), and
    `:machine` (to have Chef Infra Client determine the architecture
    during a Chef Infra Client run).

    In order to read or write 32-bit registry keys on 64-bit machines
    running Microsoft Windows, the `architecture` property must be set
    to `:i386`. The `:x86_64` value can be used to force writing to a
    64-bit registry location, but this value is less useful than the
    default (`:machine`) because Chef Infra Client returns an exception
    if `:x86_64` is used and the machine turns out to be a 32-bit
    machine (whereas with `:machine`, Chef Infra Client is able to
    access the registry key on the 32-bit machine).

`key`

:   **Ruby Type:** String \| **Default Value:**
    `The resource block's name`

    The path to the location in which a registry key is to be created or
    from which a registry key is to be deleted. Default value: the
    `name` of the resource block. See "Syntax" section above for more
    information. The path must include the registry hive, which can be
    specified either as its full name or as the 3- or 4-letter
    abbreviation. For example, both `HKLM\SECURITY` and
    `HKEY_LOCAL_MACHINE\SECURITY` are both valid and equivalent. The
    following hives are valid: `HKEY_LOCAL_MACHINE`, `HKLM`,
    `HKEY_CURRENT_CONFIG`, `HKCC`, `HKEY_CLASSES_ROOT`, `HKCR`,
    `HKEY_USERS`, `HKU`, `HKEY_CURRENT_USER`, and `HKCU`.

`recursive`

:   **Ruby Type:** true, false \| **Default Value:** `false`

    When creating a key, this value specifies that the required keys for
    the specified path are to be created. When using the `:delete_key`
    action in a recipe, and if the registry key has subkeys, then set
    the value for this property to `true`. The `:delete_key` action with
    the `recursive` attribute will delete the registry key, all of its
    values and all of the names, types, and data associated with them.
    This cannot be undone by Chef Infra Client.

`values`

:   **Ruby Type:** Hash, Array

    An array of hashes, where each Hash contains the values that are to
    be set under a registry key. Each Hash must contain `name:`,
    `type:`, and `data:` (and must contain no other key values).

    `type:` represents the values available for registry keys in
    Microsoft Windows. Use `:binary` for REG_BINARY, `:string` for
    REG_SZ, `:multi_string` for REG_MULTI_SZ, `:expand_string` for
    REG_EXPAND_SZ, `:dword` for REG_DWORD, `:dword_big_endian` for
    REG_DWORD_BIG_ENDIAN, or `:qword` for REG_QWORD.

    <div class="alert-warning">

    `:multi_string` must be an array, even if there is only a single
    string.

    </div>