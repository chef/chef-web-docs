# linkchecker setup

linkchecker is a free, open-source website validator that checks links in web documents
and full sites. This team uses it in the `fix-broken-links` skill to find dead links in
documentation and map them back to their Markdown source files.

## Install linkchecker

The recommended installation method is `pipx`, which installs linkchecker in an isolated
Python environment and makes it available on your PATH.

**macOS, Linux, and Windows (pipx)**:

```shell
pipx install linkchecker
```

**macOS (Homebrew)**:

```shell
brew install linkchecker
```

**pip (any platform)**:

```shell
pip install linkchecker
```

Verify the installation:

```shell
linkchecker --version
```

## Basic usage

Check a locally served site recursively:

```shell
linkchecker http://localhost:1313/
```

Check a local build output directory:

```shell
linkchecker file:///path/to/public/
```

Check a deployed site:

```shell
linkchecker https://docs.example.com/
```

## Output formats

The `fix-broken-links` skill uses CSV output for machine-readable results:

```shell
linkchecker -F csv/utf-8/linkchecker-errors.csv -o none <target>
```

`-F csv/utf-8/linkchecker-errors.csv`
: Write errors to `linkchecker-errors.csv` in the current directory, encoded as UTF-8.

`-o none`
: Suppress console output. Results go to the file only.

Other useful output formats for manual inspection:

```shell
# Human-readable text to the terminal
linkchecker <target>

# HTML report
linkchecker -o html <target> > report.html
```

## Scope checks with URL filters

Use `--no-follow-url` to prevent linkchecker from recursing outside a section or domain.
The value is a Python regular expression matched against each URL before recursion.

### Check only one section of a site

To check `/platform/v2/` on a localhost site and not follow links outside that section:

```shell
linkchecker \
  --no-follow-url='^http://localhost:1313(?!/platform/v2/)' \
  http://localhost:1313/platform/v2/
```

The regex `^http://localhost:1313(?!/platform/v2/)` matches any URL on the localhost host
that does not start with `/platform/v2/`, preventing linkchecker from recursing into it.
External links are still checked for validity (just not recursed into).

To restrict to a section of a deployed site:

```shell
linkchecker \
  --no-follow-url='^https://docs.example.com(?!/platform/v2/)' \
  https://docs.example.com/platform/v2/
```

### Ignore specific URL patterns

Use `--ignore-url` to skip URLs that match a pattern entirely — they will not be checked
at all, not even for syntax:

```shell
# Ignore all URLs under /api/legacy/
linkchecker --ignore-url='/api/legacy/' <target>

# Ignore mailto: links
linkchecker --ignore-url='^mailto:' <target>

# Ignore multiple patterns
linkchecker \
  --ignore-url='^mailto:' \
  --ignore-url='/api/legacy/' \
  <target>
```

### Check external links

By default, linkchecker validates external URLs for syntax but does not make HTTP requests
to them. To also check whether external URLs are reachable:

```shell
linkchecker --check-extern <target>
```

External checks increase runtime significantly. If a server rate-limits requests,
linkchecker may report false positives. Use this flag selectively.

## Configuration file

For repeated use or team-shared settings, create a `linkcheckerrc` configuration file.
linkchecker looks for it at `$XDG_CONFIG_HOME/linkchecker/linkcheckerrc` on Linux and
macOS, and `%APPDATA%\linkchecker\linkcheckerrc` on Windows. You can also pass a config
file path with `-f`:

```shell
linkchecker -f linkcheckerrc <target>
```

### Example linkcheckerrc

```ini
[checking]
# Check external URLs (set to 1 to enable)
checkextern=0

# Number of parallel threads
threads=10

# Connection timeout in seconds
timeout=60

[filtering]
# Ignore these URL patterns (one per line, Python regex)
ignoreurl=^mailto:
ignoreurl=^javascript:
ignoreurl=/api/legacy/

# Do not recurse into these URL patterns (still check, just don't follow)
nofollow=^https://external-vendor.example.com

[output]
# Log level: debug, info, warning, error
log=warning

# Suppress status output
status=0
```

### Per-repo config for multi-repo docs sites

When a single docs site spans multiple repositories, keep a `linkcheckerrc` in each repo
that restricts checking to the section that repo owns:

```ini
[filtering]
# Only recurse into the section this repo owns
nofollow=^http://localhost:1313(?!/platform/v2/)
```

Run linkchecker from that repo directory:

```shell
linkchecker -f linkcheckerrc http://localhost:1313/platform/v2/
```

## Handling authentication

For sites that require HTTP basic authentication:

```shell
linkchecker --user=<username> --password <target>
```

linkchecker prompts for the password. To avoid interactive prompts, pass credentials
through environment variables or a `linkcheckerrc` file (see the
[linkcheckerrc man page](https://linkchecker.github.io/linkchecker/man/linkcheckerrc.html)
for the `[authentication]` section).

## Common errors and causes

`404 Not Found`
: The page has moved or been deleted. Search for a replacement using the page title or slug.

`Connection refused` / `Connection timed out`
: The server is not running (for localhost targets) or is unreachable. Check that the local
dev server is running before re-checking.

`SSLError`
: The server's TLS certificate is invalid or self-signed. For local development servers,
this is expected. Add `--no-robots` if the robots.txt is also inaccessible.

`Too many redirects`
: The link leads to a redirect loop. Trace the redirect chain manually with `curl -I <url>`.

`URL syntax error`
: The URL is malformed — for example, a space character or an unescaped `[` in the URL.
Fix the URL in the Markdown source directly.
