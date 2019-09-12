The dsc_script resource has the following properties:

`code`

:   **Ruby Type:** String

    The code for the DSC configuration script. This property may not be
    used in conjunction with the `command` property.

`command`

:   **Ruby Type:** String

    The path to a valid Windows PowerShell data file that contains the
    DSC configuration script. This data file must be capable of running
    independently of Chef and must generate a valid DSC configuration.
    This property may not be used in conjunction with the `code`
    property.

`configuration_data`

:   **Ruby Type:** String

    The configuration data for the DSC script. The configuration data
    must be [a valid Windows PowerShell data
    file](https://docs.microsoft.com/en-us/powershell/developer/windows-powershell).
    This property may not be used in conjunction with the
    `configuration_data_script` property.

`configuration_data_script`

:   **Ruby Type:** String

    The path to a valid Windows PowerShell data file that also contains
    a node called `localhost`. This property may not be used in
    conjunction with the `configuration_data` property.

`configuration_name`

:   **Ruby Type:** String

    The name of a valid Windows PowerShell cmdlet. The name may only
    contain letter (a-z, A-Z), number (0-9), and underscore (_)
    characters and should start with a letter. The name may not be null
    or empty. This property may not be used in conjunction with the
    `code` property.

`cwd`

:   **Ruby Type:** String

    The current working directory.

`environment`

:   **Ruby Type:** Hash

    A Hash of environment variables in the form of
    `({'ENV_VARIABLE' => 'VALUE'})`. (These variables must exist for a
    command to be run successfully.)

`flags`

:   **Ruby Type:** Hash

    Pass parameters to the DSC script that is specified by the `command`
    property. Parameters are defined as key-value pairs, where the value
    of each key is the parameter to pass. This property may not be used
    in the same recipe as the `code` property. For example:
    `flags ({ :EditorChoice => 'emacs', :EditorFlags => '--maximized' })`.

`imports`

:   **Ruby Type:** Array

    <div class="alert-warning">

    This property **MUST** be used with the `code` attribute.

    </div>

    Use to import DSC resources from a module.

    To import all resources from a module, specify only the module name:

    ``` ruby
    imports 'module_name'
    ```

    To import specific resources, specify the module name, and then
    specify the name for each resource in that module to import:

    ``` ruby
    imports 'module_name', 'resource_name_a', 'resource_name_b', ...
    ```

    For example, to import all resources from a module named
    `cRDPEnabled`:

    ``` ruby
    imports 'cRDPEnabled'
    ```

    To import only the `PSHOrg_cRDPEnabled` resource:

    ``` ruby
    imports 'cRDPEnabled', 'PSHOrg_cRDPEnabled'
    ```

`timeout`

:   **Ruby Type:** Integer

    The amount of time (in seconds) a command is to wait before timing
    out.