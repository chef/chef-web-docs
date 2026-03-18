# markdownlint-cli2 setup

markdownlint-cli2 is a fast Markdown linter with an auto-fix mode that corrects the majority
of formatting issues in place. This team uses it as the first stage of the `docs-style-edit`
skill to catch structural and formatting problems before prose linting begins.

## Install markdownlint-cli2

**macOS and Linux (npm)**:

```shell
npm install -g markdownlint-cli2
```

**macOS (Homebrew)**:

```shell
brew install markdownlint-cli2
```

**Windows (npm)**:

```shell
npm install -g markdownlint-cli2
```

**Windows (Scoop)**:

```shell
scoop install markdownlint-cli2
```

Verify the installation:

```shell
markdownlint-cli2 --version
```

## Configure markdownlint-cli2 for a docs repo

Copy the team config file to the root of your docs repo:

```shell
# Run from the docs repo root
cp .github/skills/docs-style-edit/assets/.markdownlint.yaml .
```

The config file sets the rules appropriate for DevOps technical documentation.
See [.markdownlint.yaml](../assets/.markdownlint.yaml) for the full rule set and comments
explaining each setting.

## Run markdownlint-cli2

**Lint a single file**:

```shell
markdownlint-cli2 docs/my-file.md
```

**Auto-fix a single file** (corrects most issues in place):

```shell
markdownlint-cli2 --fix docs/my-file.md
```

**Lint all Markdown files in a directory**:

```shell
markdownlint-cli2 "docs/**/*.md"
```

## Common rules and how to fix them

| Rule | What it flags | How to fix |
|------|--------------|------------|
| `MD009` | Trailing spaces | Remove trailing whitespace at end of lines |
| `MD010` | Hard tabs | Replace tabs with spaces |
| `MD012` | Multiple consecutive blank lines | Reduce to a single blank line |
| `MD022` | Headings not surrounded by blank lines | Add a blank line before and after every heading |
| `MD031` | Fenced code blocks not surrounded by blank lines | Add a blank line before ` ``` ` and after ` ``` ` |
| `MD032` | Lists not surrounded by blank lines | Add a blank line before and after every list |
| `MD033` | Inline HTML | Replace with equivalent Markdown where possible |
| `MD040` | Fenced code blocks without a language identifier | Add an identifier: ` ```shell `, ` ```yaml `, etc. |
| `MD041` | First line is not a top-level heading | Ensure the file starts with an `# H1` heading |
| `MD049` | Emphasis style | Use `*` consistently instead of `_` (or vice versa, per config) |

Most of these are auto-fixed by `markdownlint-cli2 --fix`. Rules that require judgement
(like `MD033` — inline HTML) are reported but not auto-fixed.

## Disable a rule for a specific block

Wrap the content in comment markers to suppress a rule locally:

```markdown
<!-- markdownlint-disable MD033 -->
<details>
<summary>Expand for details</summary>
Content here
</details>
<!-- markdownlint-enable MD033 -->
```

## Disable a rule for the whole file

Add a comment at the top of the file:

```markdown
<!-- markdownlint-disable MD041 -->
```

## Disable a rule globally

Add it to `.markdownlint.yaml` with a value of `false`:

```yaml
MD041: false
```

## Update markdownlint-cli2

```shell
npm update -g markdownlint-cli2
```
