The windows_package resource has the following properties:

`checksum`

:   **Ruby Type:** String

    The SHA-256 checksum of the file. Use to prevent a file from being
    re-downloaded. When the local file matches the checksum, Chef Infra
    Client does not download it. Use when a URL is specified by the
    `source` property.

`installer_type`

:   **Ruby Type:** Symbol

    A symbol that specifies the type of package. Possible values:
    `:custom` (such as installing a non-.msi file that embeds an
    .msi-based installer), `:inno` (Inno Setup), `:installshield`
    (InstallShield), `:msi` (Microsoft Installer Package (MSI)), `:nsis`
    (Nullsoft Scriptable Install System (NSIS)), `:wise` (Wise).

`options`

:   **Ruby Type:** String

    One (or more) additional options that are passed to the command.

`package_name`

:   **Ruby Type:** String, Array

    An optional property to set the package name if it differs from the
    resource block's name.

`remote_file_attributes`

:   **Ruby Type:** Hash

    A package at a remote location define as a Hash of properties that
    modifies the properties of the **remote_file** resource.

`returns`

:   **Ruby Type:** Integer, Array of integers \| **Default Value:** `0`

    A comma-delimited list of return codes that indicate the success or
    failure of the command that was run remotely. This code signals a
    successful `:install` action.

`source`

:   **Ruby Type:** String

    Optional. The path to a package in the local file system. The
    location of the package may be at a URL. Default value: the `name`
    of the resource block. See the "Syntax" section above for more
    information.

    If the `source` property is not specified, the package name MUST be
    exactly the same as the display name found in **Add/Remove
    programs** or exactly the same as the `DisplayName` property in the
    appropriate registry key, which may be one of the following:

    ``` ruby
    HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall
    HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall
    HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
    ```

    <div class="alert-info">

    If there are multiple versions of a package installed with the same
    display name, all of those packages will be removed unless a version
    is provided in the `version` property or unless it can be discovered
    in the installer file specified by the `source` property.

    </div>

`timeout`

:   **Ruby Type:** String, Integer \| **Default Value:** `600` (seconds)

    The amount of time (in seconds) to wait before timing out.

`version`

:   **Ruby Type:** String, Array

    The version of a package to be installed or upgraded.