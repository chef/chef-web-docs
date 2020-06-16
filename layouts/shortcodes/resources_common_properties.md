The following properties are common to every resource:

`ignore_failure`

:   **Ruby Type:** true, false, :quiet \| **Default Value:** `false`

    Continue running a recipe if a resource fails for any reason.
    `:quiet` will not display the full stack trace and the recipe will continue to run if a resource fails.

`retries`

:   **Ruby Type:** Integer \| **Default Value:** `0`

    The number of attempts to catch exceptions and retry the resource.

`retry_delay`

:   **Ruby Type:** Integer \| **Default Value:** `2`

    The retry delay (in seconds).

`sensitive`

:   **Ruby Type:** true, false \| **Default Value:** `false`

    Ensure that sensitive resource data is not logged by Chef Infra
    Client.
