The windows_env resource has the following properties:

`delim`

:   **Ruby Type:** String, false

    The delimiter that is used to separate multiple values for a single
    key.

`key_name`

:   **Ruby Type:** String \| **Default Value:**
    `The resource block's name`

    An optional property to set the name of the key that is to be
    created, deleted, or modified if it differs from the resource
    block's name.

`user`

:   **Ruby Type:** String \| **Default Value:** `"<System>"`

`value`

:   **Ruby Type:** String \| `REQUIRED`

    The value of the environmental variable to set.