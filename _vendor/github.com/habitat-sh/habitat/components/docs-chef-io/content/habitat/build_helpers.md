+++
title = "Build Helpers"
description = "Define package buildtime actions with helper functions."

[menu]
  [menu.habitat]
    title = "Build Helpers"
    identifier = "habitat/reference/build-helpers"
    parent = "habitat/reference"

+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/build_helpers.md)

The following helper functions can be useful in your plan to help you build your package correctly. `Attach()` specifically is to help with debugging - the other helper functions are to help you in building your package.

{{< note >}}
Most of the following helper functions are not available in Powershell plans (`plan.ps1`). However in most cases, the standard Powershell cmdlets provide the same functionality. For example: use `Resolve-Path` instead of `abspath` or `Get-Command` instead of `exists`.
{{< /note >}}

attach()
: `plan.sh` only. Attaches your script to an interactive debugging session, which lets you check the state of variables, call arbitrary functions, and turn on higher levels of logging by using the `set -x` command and switch.

  To use attach, add `attach` to any callback or part of your plan.sh file and the debugging session with start up when hab-plan-build comes to that part in the file.

{{< note >}}
Use the native Powershell cmdlet `Set-PSBreakpoint` for debugging plan.ps1 functions. You can set its `-Command` parameter to any build phase function.
{{< /note >}}

download_file()
: `plan.sh` only. Downloads a file from a source URL to a local file and uses an optional
shasum to determine if an existing file can be used.

```bash
download_file <source_url> <local_file> [<shasum>]
```

If an existing file is present and the third argument is set with a shasum
digest, the file will be checked to see if it's valid. If so, the function
ends early and returns 0. Otherwise, the shasums do not match so the
file-on-disk is removed and a normal download proceeds as though no previous
file existed. This is designed to restart an interrupted download.

Any valid `wget` URL will work.

Downloads every time, even if the file exists locally:

```bash
download_file http://example.com/file.tar.gz file.tar.gz
```

Downloads if no local file is found:

```bash
download_file http://example.com/file.tar.gz file.tar.gz expected_shasum
```

File matches checksum: download is skipped, local file is used:

```bash
download_file http://example.com/file.tar.gz file.tar.gz expected_shasum
```

File doesn't match checksum: local file removed, download attempted:

```bash
download_file http://example.com/file.tar.gz file.tar.gz mismatching_shasum
```

Will return 0 if a file was downloaded or if a valid cached file was found.

pkg\_path\_for()/Get-HabPackagePath
: Returns the path for a build or runtime package dependency on stdout from the list of dependencies referenced in `pkg_deps` or `pkg_build_deps`. This is useful if you need to install or reference specific dependencies from within a callback, such as `do_build()` or `do_install()`.

  Here's an example of how to use this function to retrieve the path to the perl binary in the core/perl package:

```bash
_perl_path="$(pkg_path_for core/perl)/bin/perl"
```

fix_interpreter()
: `plan.sh` only. Edits the `#!` shebang of the target file in-place. This is useful for changing hard-coded paths defined by your source files to the equivalent path in a Chef Habitat package. You must include the required package that provides the expected path for the shebang in pkg_deps. This function performs a greedy match against the specified interpreter in the target file(s).

To use this function in your plan, you must specify the following arguments:

  1. The target file or files
  2. The name of the package that contains the interpreter
  3. The relative directory and binary path to the interpreter

For example, to replace all the files in `node_modules/.bin` that have `#!/usr/bin/env` with the coreutils path to `bin/env` (/hab/pkgs/core/coreutils/8.24/20160219013458/bin/env), you must quote the wildcard target as shown below.

```bash
fix_interpreter "node_modules/.bin/*" core/coreutils bin/env
```

For a single target, reference the file directly:

```bash
fix_interpreter node_modules/.bin/concurrent core/coreutils bin/env
```

pkg\_interpreter\_for()
: `plan.sh` only. Returns the path for the given package and interpreter by reading it from the INTERPRETERS metadata in the package. The directory of the interpreter needs to be specified, as an interpreter binary might live in `bin`, `sbin`, or `libexec`, depending on the software.

The following shows how to call pkg_interpreter_for with the package and interpreter arguments specified.

```bash
pkg_interpreter_for core/coreutils bin/env
```

This function will return 0 if the specified package and interpreter were found, and 1 if the package could not be found or the interpreter is not specified for that package.

pkg_version()
: An optional way to determine the value for `$pkg_version`. The function must print the computed version string to standard output and will be called when the Plan author invokes the `update_pkg_version()` helper in a `plan.sh` or `Set-PkgVersion` in a `plan.ps1`.

update\_pkg\_version()/Set-PkgVersion
: Updates the value for `$pkg_version` by calling a Plan author-provided `pkg_version()` function. This function must be explicitly called in a Plan in or after the `do_before()`/`Invoke-Before` build phase but before the `do_prepare()`/`Invoke-Prepare` build phase. The `$pkg_version` variable will be updated and any other relevant variables will be recomputed. The following examples show how to use these functions to set a dynamic version number.

This plan concatenates a static file in the source root of the
project to determine the version in the `before` phase:

{{< foundation_tabs tabs-id="bash-powershell-panel1" >}}
  {{< foundation_tab active="true" panel-link="bash-panel1" tab-text="Bash">}}
  {{< foundation_tab panel-link="powershell-panel1" tab-text="Powershell" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="bash-powershell-panel1" >}}
  {{< foundation_tabs_panel active="true" panel-id="bash-panel1" >}}
  ```bash
  pkg_version() {
  cat "$SRC_PATH/version.txt"
  }

  do_before() {
  do_default_before
  update_pkg_version
  }
  ```
  {{< /foundation_tabs_panel >}}

  {{< foundation_tabs_panel panel-id="powershell-panel1" >}}
  ```powershell
  function pkg_version {
  Get-Content "$SRC_PATH/version.txt"
  }

  Invoke-Before {
  Invoke-DefaultBefore
  Set-PkgVersion
  }
  ```
  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

The `pkg_version` function in this plan dynamically creates a version with a date stamp to format the final version string to standard output.
As the downloaded file is required before running the version logic, this helper function is called in the `download` build phase:

{{< foundation_tabs tabs-id="bash-powershell-panel2" >}}
  {{< foundation_tab active="true" panel-link="bash-panel2" tab-text="Bash">}}
  {{< foundation_tab panel-link="powershell-panel2" tab-text="Powershell" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="bash-powershell-panel2" >}}
  {{< foundation_tabs_panel active="true" panel-id="bash-panel2" >}}
  ```bash
  pkg_version() {
  local build_date

  # Extract the build date of the certificates file
  build_date=$(cat $HAB_CACHE_SRC_PATH/$pkg_filename \
    | grep 'Certificate data from Mozilla' \
    | sed 's/^## Certificate data from Mozilla as of: //')

  date --date="$build_date" "+%Y.%m.%d"
  }

  do_download() {
  do_default_download
  update_pkg_version
  }
  ```
  {{< /foundation_tabs_panel >}}

  {{< foundation_tabs_panel panel-id="powershell-panel2" >}}
  ```powershell
  function pkg_version {
    # Extract the build date of the certificates file
    $matchStr = "## Certificate data from Mozilla as of: "
    foreach($line in (Get-Content "$HAB_CACHE_SRC_PATH/$pkg_filename")) {
      if($line.StartsWith($matchStr)) {
        $build_date = $line.Substring($matchStr.Length)
      }
    }

    [DateTime]::Parse($build_date).ToString("yyyy.mm.dd")
  }

  function Invoke-Download {
    Invoke-DefaultDownload
    Set-PkgVersion
  }
  ```
  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

abspath()
: `plan.sh` only. Return the absolute path for a path, which might be absolute or relative.

exists()
: `plan.sh` only. Checks that the command exists. Returns 0 if it does, 1 if it does not.

build_line()/Write-BuildLine
: Print a line of build output. Takes a string as its only argument.

```bash
build_line "Checksum verified - ${pkg_shasum}"
```

warn()/Write-Warning
: Print a warning line on stderr. Takes a string as its only argument.

```bash
warn "Checksum failed"
```

debug()/Write-Debug
: Prints a line only if the `$DEBUG` environment value is set to 1. The `debug` function takes a string as its only argument.

```bash
DEBUG=1
debug "Only if things are set"
```

exit_with()
: `plan.sh` only. Exits the program with an error message and a status code.

```bash
exit_with "Something bad happened" 55
```

trim()
: `plan.sh` only. Trims leading and trailing whitespace characters from a bash variable.

record()
: `plan.sh` only. Takes a session name and command to run as arguments function appends a timestamp to the log file. Alternative to piping build through tee.

```bash
# Usage: record <SESSION> [CMD [ARG ...]]
record mysoftware build /src/mysoftware
```
