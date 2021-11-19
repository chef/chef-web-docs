This subcommand has the following options:

`-c`, `--cleanse`

:   Use to remove all existing data on the Chef Infra Server; it will be
    replaced by the data in the backup archive.

`-d DIRECTORY`, `--staging-dir DIRECTORY`

:   Use to specify that the path to an empty directory to be used during
    the restore process. This directory must have enough disk space to
    expand all data in the backup archive.

`--pg-options`

:   Use to specify additional options to pass to PostgreSQL during restore. See the [PostgreSQL documentation](https://www.postgresql.org/docs/13/runtime-config.html) for more information.

`-t`, `--timeout`

:   Set the maximum amount of time in seconds to wait for shell commands (default 600). This option should be set to greater than 600 for restores taking longer than 10 minutes.

`-h`, `--help`

:   Show help message.
