# dtags utility

The `dtags` command lets you query and manipulate regions of
restructuredText files that use `.. tag` and `.. end_tag` comments to
annotate shared content. Here is a tagged region named `foo_summary`:

```bash
   .. tag foo_summary

   **Foo** does lots of things.

   .. end_tag
```

* Tagged regions may be indented, and if so, the whitespace to the left of the indentation until the `.. end_tag` is not considered part of the tagged region.
* The `..tag` and `.. end_tag` must have the same indentation, and the body must have at least that indentation.
* The `tag` line should be followed by a blank line.
* The `end_tag` line should be preceded by a blank line.
* The name that follows `tag` must use only lowercase letters, digits and the underscore character.
* It's ok for tagged regions to be nested.
* We recommend that you use tags only for content that appears in more than one place.

Note that `.. tag` and `.. tag_end` are comments in
restructuredText. They are ignored by the Sphinx documentation
generator.

`dtags` searches for files in the current working directory. For convenience, you'll want to put it in your path, make a symbolic link or create an alias. The `dtags` script is located in the the `doctools` directory of this repo.

Usage:

```bash
   dtags [--help] <command> [<args>]
```

The `dtags` command has subcommands. These are:

      check       Checks for tagged regions with inconsistent contents.
      replicate   Propagates tagged regions to other files
      whereis     Prints locations of tagged regions
      list        Lists tags in use
      print       Prints the contents of tagged regions
      help        Prints help for any of these commands

## dtags check

Usage:

```bash
  dtags check [(<regexp> | "--") [<topic> [<topic2>]]]
```

The `dtags check` command lists tags with multiple (inconsistent)
definitions. If `<regexp>` is given, only tags whose names match
`<regexp>` are checked. `dtags` uses Ruby regex syntax, but it assumes
that `/^ .. $/` is the context. For example, use `"foo.*"` to select tags
that start with the "foo". The value `--` can be used as a placeholder
if no regex is needed.

`<topic>`, if given, limits the check to tag names that match regexp and
are also found in `<topic>`.

`<topic2>`, if given, limits the check to tags found in `<topic>` that are
inconsistent with their definitions in `<topic2>`. If absent, all .rst
files in the current directory will be checked.

The output, printed to stderr, shows tag name, tag version hash, plus
where-used file name and line no.

The command exits with status 1 if the check fails.

For example,

```bash
     dtags check foo
```

processes only tag `foo` while

```bash
     dtags check "foo.*"
```

checks all tags starting with "foo" in the current working directory.

### Example

```bash
dtags check
Inconsistent tagged regions:
  foo_summary e8ae754 foo.rst:6
  foo_summary 5a93da7 bar.rst:3
```

## dtags replicate

Usage:

```bash
  dtags replicate (<regexp> | "--") <topic> [<topic2>]
```

The `dtags replicate` command collects all tags matching `<regexp>` found
in `<topic>` and replaces the contents of those tags in all other topics
(or just in `<topic2>`, if provided) with the corresponding text from
`<topic>`.

The `<regexp>` argument restricts replication to tags whose names match
`<regexp>` instead of all tags. `<regexp>` uses the Ruby regex engine, but
it assumes that `/^ .. $/` is the context. For example, `"foo.*"` selects
tags that start with the "foo". The value `--` can be used as a
placeholder if no regex is needed.

`<topic>` is a file name, with an optional line number given by
":`<digits>`".  If a line number is present, it specifies the tag on the
given line.  For example,

    dtags replicate foo mydoc.rst:43 yourdoc.rst

has the following effect. If mydoc.rst line 43 contains ".. tag foo",
then the body of all foo tags in yourdoc.rst will be replaced with the
text taken from the foo tag located in mydoc.rst at line 43.

Note: If you've used the same tag more than once but with different
body definitions within `<topic>`, then `dtags` will give an
error. For now, if you've used the same tag inconsistently within a
single file, you'll need to resolve the conflict by editing the file.

## dtags whereis

Usage:

```bash
  dtags whereis (<regexp> | "--") [<topic> [<topic2>]]
```

The `dtags whereis` command finds tags whose names match `<regexp>` and
lists where they are used in the current directory, or just in
`<topic2>`, if specified.

If `<regexp>` is given, the command only considers tags whose names
match `<regexp>` instead of all tags. `<regexp>` uses the Ruby regex
engine, but it assumes that `/^ .. $/` is the context. For example,
`"foo.*"` selects tags that start with the "foo". The value -- can be
used as a placeholder if no regex is needed.

The output shows tag name, tag version hash as well as the file name
and line number where each tagged region begins.

`<topic>`, if given, limits the output to tags in `<topic>` that match
`<regexp>`.

## dtags list

Usage:

```bash
  dtags list [(<regexp> | "--") [<topic> [<topic2>]]
```

The `dtags list` command scans the current directory and subdirectory
(or just `<topic2>`, if provided) and prints tag names that match
`<regexp>`, possibly limiting them to tags found in `<topic>`.

If `<regexp>` is given, the command only considers tags whose names
match `<regexp>` instead of all tags. `<regexp>` uses the Ruby regex
engine, but it assumes that `/^ .. $/` is the context. For example,
`"foo.*"` selects tags that start with the "foo". The value -- can be
used as a placeholder if no regex is needed.

The results are in alphabetical order.

## dtags print

Usage:

```bash
  dtags print (<regexp> | "--") [`<topic> [`<topic2>]]
```

The `dtags print` command writes the contents of matching tags matching
`<regexp>` and found in `<topic>`. The tagged regions to print are taken
from all files or only from `<topic2>`, if given.

If `<regexp>` is given, the command only considers tags whose names
match `<regexp>` instead of all tags. `<regexp>` uses the Ruby regex
engine, but it assumes that `/^ .. $/` is the context. For example,
`"foo.*"` selects tags that start with the "foo". The value `--` can be
used as a placeholder if no regex is needed.

## dtags help

Usage:

```bash
  dtags help <command>
```

The dtags help command prints help for the commands: check,
replicate, whereis, list, print, and help.
