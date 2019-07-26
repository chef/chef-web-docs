The powershell_script resource has the following properties:

`architecture`

:   **Ruby Type:** Symbol

    The architecture of the process under which a script is executed. If
    a value is not provided, Chef Infra Client defaults to the correct
    value for the architecture, as determined by Ohai. An exception is
    raised when anything other than `:i386` is specified for a 32-bit
    process. Possible values: `:i386` (for 32-bit processes) and
    `:x86_64` (for 64-bit processes).

`code`

:   **Ruby Type:** String \| `REQUIRED`

    A quoted (" ") string of code to be executed.

`command`

:   **Ruby Type:** String, Array \| **Default Value:**
    `The resource block's name`

    An optional property to set the command to be executed if it differs
    from the resource block's name.

`convert_boolean_return`

:   **Ruby Type:** true, false \| **Default Value:** `false`

    Return `0` if the last line of a command is evaluated to be true or
    to return `1` if the last line is evaluated to be false.

    When the `guard_interpreter` common attribute is set to
    `:powershell_script`, a string command will be evaluated as if this
    value were set to `true`. This is because the behavior of this
    attribute is similar to the value of the `"$?"` expression common in
    UNIX interpreters. For example, this:

    ``` ruby
    powershell_script 'make_safe_backup' do
      guard_interpreter :powershell_script
      code 'cp ~/data/nodes.json ~/data/nodes.bak'
      not_if 'test-path ~/data/nodes.bak'
    end
    ```

    is similar to:

    ``` ruby
    bash 'make_safe_backup' do
      code 'cp ~/data/nodes.json ~/data/nodes.bak'
      not_if 'test -e ~/data/nodes.bak'
    end
    ```

`creates`

:   **Ruby Type:** String

    Prevent a command from creating a file when that file already
    exists.

`cwd`

:   **Ruby Type:** String

    The current working directory from which the command will be run.

`environment`

:   **Ruby Type:** Hash

    A Hash of environment variables in the form of ({'ENV_VARIABLE' =\>
    'VALUE'}).

`flags`

:   **Ruby Type:** String

    A string that is passed to the Windows PowerShell command. Default
    value (Windows PowerShell 3.0+):
    `-NoLogo, -NonInteractive, -NoProfile, -ExecutionPolicy Bypass, -InputFormat None`.

`group`

:   **Ruby Type:** String, Integer

    The group name or group ID that must be changed before running a
    command.

`guard_interpreter`

:   **Ruby Type:** Symbol \| **Default Value:** `:powershell_script`

    When this property is set to `:powershell_script`, the 64-bit
    version of the Windows PowerShell shell will be used to evaluate
    strings values for the `not_if` and `only_if` properties. Set this
    value to `:default` to use the 32-bit version of the cmd.exe shell.

`interpreter`

:   **Ruby Type:** String

    The script interpreter to use during code execution. Changing the
    default value of this property is not supported.

`returns`

:   **Ruby Type:** Integer, Array \| **Default Value:** `0`

    Inherited from **execute** resource. The return value for a command.
    This may be an array of accepted values. An exception is raised when
    the return value(s) do not match.

`timeout`

:   **Ruby Type:** Integer, Float

    The amount of time (in seconds) a command is to wait before timing
    out.

`user`

:   **Ruby Type:** String

    The user name of the user identity with which to launch the new
    process. The user name may optionally be specified with a domain,
    i.e. <span class="title-ref">domain\\user</span> or <span
    class="title-ref">user@my.dns.domain.com</span> via Universal
    Principal Name (UPN)format. It can also be specified without a
    domain simply as user if the domain is instead specified using the
    <span class="title-ref">domain</span> attribute. On Windows only, if
    this property is specified, the <span
    class="title-ref">password</span> property must be specified.

`password`

:   **Ruby Type:** String

    *Windows only*: The password of the user specified by the <span
    class="title-ref">user</span> property. Default value: <span
    class="title-ref">nil</span>. This property is mandatory if <span
    class="title-ref">user</span> is specified on Windows and may only
    be specified if <span class="title-ref">user</span> is specified.
    The <span class="title-ref">sensitive</span> property for this
    resource will automatically be set to true if password is specified.

`domain`

:   **Ruby Type:** String

    *Windows only*: The domain of the user specified by the <span
    class="title-ref">user</span> property. Default value: <span
    class="title-ref">nil</span>. If not specified, the user name and
    password specified by the <span class="title-ref">user</span> and
    <span class="title-ref">password</span> properties will be used to
    resolve that user against the domain in which the system running
    Chef Infra Client is joined, or if that system is not joined to a
    domain it will resolve the user as a local account on that system.
    An alternative way to specify the domain is to leave this property
    unspecified and specify the domain as part of the <span
    class="title-ref">user</span> property.

`elevated`

:   **Ruby Type:** true, false

    Determines whether the script will run with elevated permissions to
    circumvent User Access Control (UAC) interactively blocking the
    process.

    This will cause the process to be run under a batch login instead of
    an interactive login. The user running Chef needs the "Replace a
    process level token" and "Adjust Memory Quotas for a process"
    permissions. The user that is running the command needs the "Log on
    as a batch job" permission.

    Because this requires a login, the `user` and `password` properties
    are required.