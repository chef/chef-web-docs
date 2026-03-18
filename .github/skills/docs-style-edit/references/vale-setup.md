# Vale setup

Vale is a prose linter that checks documentation against configurable style rules.
This team uses the Google and Microsoft style packages, which map to the
Google Developer Documentation Style Guide and Microsoft Writing Style Guide.

## Install vale

**macOS (Homebrew)**:

```shell
brew install vale
```

**Linux**:

```shell
# Download the latest release from https://github.com/errata-ai/vale/releases
wget https://github.com/errata-ai/vale/releases/download/v<version>/vale_<version>_Linux_64-bit.tar.gz
tar -xvzf vale_<version>_Linux_64-bit.tar.gz
sudo mv vale /usr/local/bin/
```

**Windows (Chocolatey)**:

```shell
choco install vale
```

**Windows (Scoop)**:

```shell
scoop install vale
```

Verify the installation:

```shell
vale --version
```

## Configure the Vale MCP server

The Vale MCP server lets Copilot call vale directly as a tool, returning structured data
instead of plain text. This is the preferred integration for the `docs-style-edit` skill.

Install the server:

```shell
npm install -g @errata-ai/vale-mcp
```

Add it to VS Code's MCP configuration. Open your user `settings.json`
(`Cmd/Ctrl+Shift+P` → **Preferences: Open User Settings (JSON)**) and add:

```json
"mcp": {
  "servers": {
    "vale": {
      "command": "vale-mcp",
      "args": []
    }
  }
}
```

Reload VS Code after saving. To verify the server is available, open Copilot Chat, type `/`,
and look for a tool with `vale` in the name.

> **Note**: Vale must still be installed on your PATH and `.vale.ini` must be present in the
> repo root for the MCP server to work. The MCP server is a wrapper around the vale binary —
> it does not replace it.

## Configure vale for a docs repo

1. Copy the team `.vale.ini` to the root of your docs repo:

   ```shell
   # Run from the docs repo root
   cp .github/skills/docs-style-edit/assets/.vale.ini .
   ```

2. Download the configured style packages:

   ```shell
   vale sync
   ```

   This creates a `.vale/styles/` directory containing the Google and Microsoft packages.

3. Add the downloaded styles to `.gitignore` — don't commit them:

   ```shell
   echo ".vale/styles/" >> .gitignore
   ```

4. Verify the setup:

   ```shell
   vale docs/my-file.md
   ```

## Adjust the minimum alert level

Edit `.vale.ini` to control which severity levels are reported:

```ini
# Report warnings and errors (default — recommended)
MinAlertLevel = warning

# Report everything including minor suggestions
MinAlertLevel = suggestion

# Report only blocking errors
MinAlertLevel = error
```

## Disable a specific rule

Add the rule to the `[*.md]` section of `.vale.ini` with `= NO`:

```ini
[*.md]
BasedOnStyles = Vale, Google, Microsoft
# Disable the word list check — team uses a custom list instead
Google.WordList = NO
```

## Add custom vocabulary

Vale will flag correctly spelled product names, commands, and abbreviations as spelling errors.
Add them to an accept list:

1. Create the directory and file:

   ```shell
   mkdir -p .vale/styles/Vocab/Base
   touch .vale/styles/Vocab/Base/accept.txt
   ```

2. Add one term per line:

   ```
   Kubernetes
   GitOps
   IaC
   kubectl
   Terraform
   ```

3. Register the vocabulary in `.vale.ini`:

   ```ini
   Vocab = Base
   ```

## Suppress vale in code blocks

Vale lints content inside code blocks by default.
Wrap code blocks with `<!-- vale off -->` and `<!-- vale on -->` to suppress linting within them:

```markdown
<!-- vale off -->
```shell
kubectl get pods --all-namespaces
```
<!-- vale on -->
```

## Update style packages

When vale releases updated style packages, re-run:

```shell
vale sync
```
