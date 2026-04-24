---
name: fix-broken-links
description: 'Run linkchecker against a locally served site, a deployed URL, or a local HTML build output, parse the errors, map each broken link back to its Markdown source file, suggest replacement URLs, and apply confirmed fixes. Supports scoping the check to a subsection of a site so you can work on one repository at a time in a multi-repo docs site. Triggers on: broken links, dead links, fix links, link check, linkchecker, check links, link errors, 404 links, link rot.'
argument-hint: "The check target — a localhost URL (http://localhost:1313/), a deployed URL (https://docs.example.com/), or an absolute path to a local build directory (/path/to/public/)"
---

# Fix broken links

Runs a six-stage workflow to find and fix broken links in a documentation repo:

1. **Verify installation** — confirms linkchecker is installed and the check target is ready
2. **Configure check** — builds the linkchecker command for the target type and scope
3. **Run linkchecker** — executes the check and saves errors to a CSV file
4. **Parse errors** — reads the CSV and extracts every broken link with its parent page
5. **Map to source** — maps each parent page back to its Markdown source file and finds the broken URL on the correct line
6. **Fix links** — searches the repo for a replacement URL, presents it for confirmation, and applies the fix

---

## Before running this skill

See [linkchecker-setup.md](./references/linkchecker-setup.md) for installation instructions.

Verify linkchecker is installed:

```shell
linkchecker --version
```

If the command is not found, install it:

```shell
pipx install linkchecker
```

### Check target readiness

Depending on the target type, confirm the following before running:

**Locally served site**: Start the local dev server before running this skill. The site must
be reachable at the URL you provide.

```shell
# Hugo
hugo server

# MkDocs
mkdocs serve
```

**Deployed URL**: No setup needed. Confirm you have network access to the site.

**Local build output**: Run the site generator's build command first. The output directory
must exist and contain the rendered HTML.

```shell
# Hugo
hugo

# MkDocs
mkdocs build
```

---

## Stage 1: Verify installation

Run the following command to confirm linkchecker is available:

```shell
linkchecker --version
```

If the command fails, provide the install command from the prerequisite section above and
stop the skill. Ask the user to install linkchecker and re-run.

If the user supplied a local build output path, confirm the path exists and contains at
least one HTML file:

```shell
find <build-path> -name "*.html" | head -5
```

If no HTML files are found, stop and ask the user to run the build step first.

---

## Stage 2: Configure check

Ask the user for the following if not already provided:

1. **Check target** — one of:
   - A localhost URL: `http://localhost:<port>/`
   - A deployed URL: `https://<hostname>/`
   - An absolute path to a local build directory: `/path/to/public/` or `/path/to/site/`

2. **Section prefix** (optional) — a URL path prefix to restrict the check to one section
   of the site, for example `/platform/v2/`. Leave empty to check the entire site from the
   target URL.

3. **Check external links** (optional) — whether to check links that point to external
   domains. Default is no. External checks are slower and may produce false positives from
   rate-limited servers.

### Build the linkchecker command

Use the inputs to build the command. The exact form depends on the target type.

#### Target: localhost or deployed URL

```shell
linkchecker \
  --no-status \
  -F csv/utf-8/linkchecker-errors.csv \
  -o none \
  <target-url>
```

#### Target: local build output

Construct a `file://` URL from the absolute path. On macOS and Linux, prefix the path with
`file://`:

```shell
linkchecker \
  --no-status \
  -F csv/utf-8/linkchecker-errors.csv \
  -o none \
  file://<absolute-build-path>/
```

For example, if the build path is `/home/user/docs/public/`, the target is
`file:///home/user/docs/public/`.

#### Add section scoping

If the user provided a section prefix, add a `--no-follow-url` flag to prevent linkchecker
from recursing outside that section. This keeps the check bounded to the content that this
repository owns.

Construct the regex as a negative lookahead anchored to the host:

- For localhost: `--no-follow-url='^http://localhost:<port>(?!/<section-prefix>)'`
- For a deployed URL: `--no-follow-url='^https://<hostname>(?!/<section-prefix>)'`
- For a local build path: `--no-follow-url='^file://<absolute-build-path>(?!/<section-prefix>)'`

For example, to check only the `/platform/v2/` section of a site at `http://localhost:1313/`,
add:

```
--no-follow-url='^http://localhost:1313(?!/platform/v2/)'
```

Also pass the section start URL as the entry point instead of the site root, so linkchecker
begins crawling from the correct place:

```
http://localhost:1313/platform/v2/
```

#### Add external link checking

If the user wants to check external links, add `--check-extern`:

```shell
--check-extern
```

Without this flag, linkchecker checks that external URLs are syntactically valid but does
not make HTTP requests to them.

#### Final command examples

**Localhost, scoped to a section, no external checks**:

```shell
linkchecker \
  --no-status \
  -F csv/utf-8/linkchecker-errors.csv \
  -o none \
  --no-follow-url='^http://localhost:1313(?!/platform/v2/)' \
  http://localhost:1313/platform/v2/
```

**Local build output, full site, with external checks**:

```shell
linkchecker \
  --no-status \
  --check-extern \
  -F csv/utf-8/linkchecker-errors.csv \
  -o none \
  file:///home/user/docs/public/
```

Show the user the final command and confirm before proceeding to Stage 3.

---

## Stage 3: Run linkchecker

Run the command built in Stage 2.

```shell
<linkchecker command from Stage 2>
```

Linkchecker exits with code 1 when it finds errors. This is expected and does not indicate
a problem with the command. Exit code 2 indicates a program error — if this occurs, show
the terminal output and stop.

After the command finishes, confirm that `linkchecker-errors.csv` was created:

```shell
ls -lh linkchecker-errors.csv
```

If the file does not exist or is empty (only a header line), report that no broken links
were found and stop.

---

## Stage 4: Parse errors

Read `linkchecker-errors.csv`. The CSV columns are:

```
urlname,parentname,baseref,result,warningstring,infostring,valid,url,line,col,name
```

Key columns:

`urlname`
: The URL that was checked and found to be broken.

`parentname`
: The URL of the page that contains the broken link.

`result`
: The HTTP status code or error message — for example, `404 Not Found`, `Connection refused`, `SSLError`.

`valid`
: `True` if the link is valid, `False` if broken.

`line`
: The line number in the parent page's HTML where the broken link appears. Note: this is the
HTML line number, not the Markdown source line number. Use it as a hint, not an exact target.

Filter rows where `valid` is `False`. Ignore rows where `valid` is `True`.

Group the broken links by `parentname` so that all errors on the same page are processed
together in Stage 5.

If all `valid` values are `True`, report that no broken links were found and stop.

---

## Stage 5: Map errors to Markdown source

For each unique `parentname` URL from Stage 4, find the Markdown source file that generated
that page. Then, for each broken URL on that page, find the exact line in the Markdown file.

### Step 5a: Determine the repo content root

Look for a site generator config file in the repo to identify the content root directory
and URL structure. Check in this order:

| Config file | Generator | Content root | URL-to-path pattern |
|-------------|-----------|--------------|---------------------|
| `hugo.toml`, `hugo.yaml`, `config.toml`, `config.yaml` | Hugo | `content/` | See Hugo mapping below |
| `mkdocs.yml` | MkDocs | `docs/` | See MkDocs mapping below |
| `_config.yml` | Jekyll | Root or `_posts/` | See Jekyll mapping below |
| None found | Unknown | Search by grep | See fallback below |

### Step 5b: Strip the host and build path

Extract the URL path from `parentname`:

- **Localhost or deployed URL**: strip the scheme and hostname. For `http://localhost:1313/platform/v2/install/`, the path is `/platform/v2/install/`.
- **Local build output**: strip the `file://` prefix and the build directory path. For `file:///home/user/docs/public/platform/v2/install/index.html`, strip `/home/user/docs/public` to get `/platform/v2/install/index.html`, then strip the filename to get the path `/platform/v2/install/`.

### Step 5c: Map the URL path to a Markdown file

#### Hugo

Hugo maps URL paths to Markdown files using these patterns, tried in order:

1. `content/<path>/index.md`
2. `content/<path>.md`
3. `content/<path>/_index.md`

Strip any trailing slash from the path before substituting. For path `/platform/v2/install/`:

```shell
# Try these paths in order:
content/platform/v2/install/index.md
content/platform/v2/install.md
content/platform/v2/install/_index.md
```

#### MkDocs

MkDocs maps URL paths to Markdown files using this pattern:

1. `docs/<path>/index.md`
2. `docs/<path>.md`

#### Jekyll

Jekyll maps URL paths to Markdown files using these patterns:

1. `<path>.md` from the repo root
2. `_posts/<slug>.md` for blog-style paths
3. `<path>/index.md`

#### Fallback: grep for the URL

If the generator is not recognized or none of the paths above exist, search the repo for
any Markdown file that references the parent page's URL path:

```shell
grep -rl '<url-path>' --include="*.md" .
```

### Step 5d: Find the broken URL in the Markdown file

Once the source file is identified, search it for the broken URL text:

```shell
grep -n '<broken-url>' <source-file>
```

If the broken URL is relative (for example, `../install/`), also try searching for the
last path segment:

```shell
grep -n '<last-segment>' <source-file>
```

Record the line number. If the broken URL appears on multiple lines, record all of them.

Build a table of all broken links, with:

- Source file path
- Line number in the source file
- Broken URL
- HTTP result from linkchecker

---

## Stage 6: Fix broken links

Process each broken link from Stage 5 one at a time.

### Step 6a: Search for a replacement URL

For each broken URL, search the repo for a likely replacement. Use the last one or two
path segments of the broken URL as search terms — these often match a page's filename,
slug, or title.

```shell
# Search for a matching filename
find . -name "*.md" | grep -i '<last-segment>'

# Search for a matching title in frontmatter
grep -rl '^title:.*<last-segment>' --include="*.md" .

# Search for a matching heading
grep -rn '^# .*<last-segment>' --include="*.md" .
```

Derive the likely URL for any matching file using the same generator mapping from Stage 5
(in reverse: file path → URL path).

### Step 6b: Present and confirm

For each broken link, show the user:

```
File:     <source-file>:<line>
Broken:   <broken-url>
Result:   <http-result>
Suggested replacement: <replacement-url>   [or "No replacement found"]
```

Ask the user to:
- Confirm the suggested replacement
- Provide a different URL
- Skip this link (leave it unchanged)
- Mark it as a TODO comment

Do not apply any change without explicit confirmation.

### Step 6c: Apply the fix

**Confirmed replacement**: Replace the broken URL with the confirmed URL in the Markdown
source file at the line identified in Stage 5.

Replace the URL in place, preserving the surrounding Markdown link syntax:

- `[link text](broken-url)` → `[link text](replacement-url)`
- `[broken-url]` reference-style links → update the corresponding reference definition
- Raw URLs in text → replace inline

After replacing, read the changed line back to verify the syntax is intact.

**Skipped links**: Leave unchanged. Include in the final summary.

**TODO comments**: Insert a comment on the line above the broken link:

```markdown
<!-- TODO: broken link — <broken-url> returned <http-result> -->
```

### Step 6d: Re-verify (optional)

After all fixes are applied, offer to re-run linkchecker against the same target to confirm
the error count has dropped. Run the same command from Stage 3.

---

## Final output

After all links have been processed, return an `## Fix summary` section with:

- Total broken links found
- Number fixed (with replacement URLs applied)
- Number marked as TODO
- Number skipped
- List of every change: source file, line, old URL, new URL
- List of every TODO comment added: source file, line, broken URL, HTTP result
- List of skipped links
