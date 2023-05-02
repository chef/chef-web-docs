+++
title = "Developing Documentation"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/style_tools/"]

[menu]
  [menu.overview]
    title = "Tools"
    identifier = "overview/style/tools"
    parent = "overview/style"
    weight = 40
+++
<!-- markdownlint-disable-file MD013 -->

This document covers the tools used by the @chef-docs team for developing documentation.

## Homebrew

[Homebrew](https://brew.sh/) is a package manager for macOS.
Install Homebrew with the command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
brew tap go-swagger/go-swagger && brew install go-swagger hugo node go vale git
```

This command installs:

- [Hugo](https://gohugo.io)
- [Node.js](https://nodejs.org/en/)
- [Go](https://golang.org/)
- [go-swagger](https://goswagger.io/)
- [vale](https://vale.sh/)
- [git](https://git-scm.com/)

## Chocolatey

Install [Chocolatey](https://chocolatey.org/install)

```ps
choco install choco install hugo-extended nodejs golang jq git
```

## Visual Studio Code (VSCode)

Microsoft's VSCode is a free and open source editor. VSCode offers many extensions--including a Chef extension--that provide useful language and documentation support.

Install [VSCode](https://code.visualstudio.com/)

Learn a bit about VSCode through Microsoft Learn Videos and tutorials.

- Setup Guide: [Visual Studio Code on macOS](https://code.visualstudio.com/docs/setup/mac)
- Setup Guide: [Visual Studio Code on Windows](https://code.visualstudio.com/docs/setup/windows)
- [User Interface](https://code.visualstudio.com/docs/getstarted/userinterface)
- [Integrated Terminal](https://code.visualstudio.com/docs/editor/integrated-terminal)
- [Getting started with Visual Studio Code Videos](https://code.visualstudio.com/docs/getstarted/introvideos)
- [Working with GitHub in VS Code](https://code.visualstudio.com/docs/editor/github)
- [Introduction to GitHub in Visual Studio Code](https://docs.microsoft.com/learn/modules/introduction-to-github-visual-studio-code/)

Install the extensions:

- [Docs Authoring Pack](https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-authoring-pack) (includes Code Street Spell and Markdownlint, adds some automatic configuration.)
- [Grammarly](https://marketplace.visualstudio.com/items?itemName=znck.grammarly)
- [Trailing Spaces](https://marketplace.visualstudio.com/items?itemName=shardulm94.trailing-spaces)
- [Code Street Spell](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- [Markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- [Vale](https://marketplace.visualstudio.com/items?itemName=ChrisChinchilla.vale-vscode)
- [Better TOML](https://marketplace.visualstudio.com/items?itemName=bungcip.better-toml)
- [YAML](https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-yaml)
- [GitHub Pull Requests and Issues](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)
- [Chef Extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=chef-software.Chef)
- [LiveShare](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare-pack)

### Code Spell Checker

We use CSpell dictionaries that are hosted in the [chef_dictionary GitHub repository](https://github.com/chef/chef_dictionary).

Navigate to your VSCode settings by selecting the gear icon at the bottom left side of the VSCode screen and find the Code Spell settings. In the left menu nav, select **Language and Dictionaries**, scroll down to **C Spell: Dictionary Definitions**, select **Edit in settings.json**, and add the following content in `settings.json` file:

```json
  "cSpell.dictionaryDefinitions": [
      {
        "name": "chef",
        "path": "https://raw.githubusercontent.com/chef/chef_dictionary/main/chef.txt",
        "description": "Custom Chef Dictionary"
      },
      {
        "name": "docs",
        "path": "https://raw.githubusercontent.com/chef/chef_dictionary/main/docs.txt",
        "description": "Custom Docs Dictionary"
      }
  ]
```

Add this configuration to the `settings.json` file to exclude code blocks from spellcheck:

```json
  "cSpell.languageSettings": [
    {  // use with Markdown files
      "languageId": "markdown",
      // Exclude code blocks from spellcheck.
      "ignoreRegExpList": [
          "/^\\s*```[\\s\\S]*?^\\s*```/gm"
      ]
    }
  ]
```

### Markdownlint

[Markdownlint-CLI2](https://github.com/DavidAnson/markdownlint-cli2) is a fast, flexible, configuration-based command-line interface for linting Markdown files.

Install the Markdownlint CLI into your local environment:

```bash
npm install markdownlint-cli2 --global
```

`chef/chef-web-docs/.markdownlint.yaml` is the configuration file with the Markdown rules for Chef documentation files.

This is a full list of  Markdownlint [rules](https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md)

To enable or disable rules for specific lines, add the appropriate marker:

- Disable all rules: `<!-- markdownlint-disable -->`
- Enable all rules: `<!-- markdownlint-enable -->`
- Disable all rules for the next line only: `<!-- markdownlint-disable-next-line -->`
- Disable one or more rules by name: `<!-- markdownlint-disable MD001 MD005 -->`
- Enable one or more rules by name: `<!-- markdownlint-enable MD001 MD005 -->`
- Disable one or more rules by name for the next line only: `<!-- markdownlint-disable-next-line MD001 MD005 -->`
- Capture the current rule configuration: `<!-- markdownlint-capture -->`
- Restore the captured rule configuration: `<!-- markdownlint-restore -->`

To enable or disable rules for entire files, use:

- Disable all rules: `<!-- markdownlint-disable-file -->`
- Enable all rules: `<!-- markdownlint-enable-file -->`
- Disable one or more rules by name: `<!-- markdownlint-disable-file MD001 -->`
- Enable one or more rules by name: `<!-- markdownlint-enable-file MD001 -->`

For more information about customizing Markdownlint, see the Markdownlint GitHub Repository [README](https://github.com/DavidAnson/markdownlint/blob/main/README.md#configuration).
