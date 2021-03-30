+++
title = "Developing Documentation"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/style_guide.html"]
product = []

[menu]
  [menu.overview]
    title = "Tools"
    identifier = "overview/style/style_tools"
    parent = "overview/style"
    weight = 100
+++

This document covers the tools used by the @chef-docs team for developing documentation.

## GitHub

If you do not already have one, set up your GitHub account.
https://github.com/

Download and install Git onto your computer from [git-scm.com](https://git-scm.com/download)

Configure Git:
[First time setup](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)

After you have Git setup, create a directory for your repositories. Some name this directory `code` or `repos`. Use whatever name makes sense for you.

## Homebrew

[Homebrew](https://brew.sh/) is a package manager for macOS.
Install Homebrew with the command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
brew tap go-swagger/go-swagger && brew install go-swagger hugo node go jq direnv readline openssl@1.1 gh
```

This command installs

- [Hugo](https://gohugo.io)
- [Node.js](https://nodejs.org/en/)
- [Go](https://golang.org/)
- [JQ](https://stedolan.github.io/jq/)
- [go-swagger](https://goswagger.io/)
- [direnv](https://direnv.net/)
- [readline](https://tiswww.case.edu/php/chet/readline/rltop.html)
- [openssl@1.1](https://www.openssl.org/)
- [gh](https://cli.github.com/)

## Visual Studio Code (VSCode)

Microsoft's VSCode is a free and open source editor. VSCode offers many extensions--including a Chef extension--that provide useful language and documentation support.

Install [VSCode](https://code.visualstudio.com/)

Learn a bit about VSCode through Microsoft Learn Videos and tutorials.

- Setup Guide: [Visual Studio Code on macOS](https://code.visualstudio.com/docs/setup/mac)
- Setup Guide: [Visual Studio Code on Windows](https://code.visualstudio.com/docs/setup/windows)
- [User Interface](https://code.visualstudio.com/docs/getstarted/userinterface)(https://code.visualstudio.com/docs/editor/integrated-terminal)
- [Integrated Terminal]
- [Getting started with Visual Studio Code Videos](https://code.visualstudio.com/docs/getstarted/introvideos)
- [Working with GitHub in VS Code](https://code.visualstudio.com/docs/editor/github)
- [Introduction to GitHub in Visual Studio Code](https://docs.microsoft.com/learn/modules/introduction-to-github-visual-studio-code/)

Install the extensions:

- Docs Authoring Pack (includes Code Street Spell and Markdownlint, adds some automatic configuration.)

- Code Street Spell
- Markdownlint
- Vale
- Better TOML
- YAML
- GitHub Pull Requests and Issues
- Chef Extension for Visual Studio Code
- LiveShare

### Code Spell Checker

Clone the [Chef Dictionary](https://github.com/chef/chef_dictionary) into your repository directory

```bash
gh repo clone chef/chef_dictionary
```

Navigate to your VSCode settings by selecting the gear icon at the bottom left side of the VSCode screen and find the Code Spell settings. Open the setting for "C Spell Dictionaries" and add the following content, adjusting the path for your local workstation

```json
  "cSpell.dictionaryDefinitions": [
  { "name": "chef_dictionary",
    "path": "/Users/<username>/<repodir>/chef_dictionary/chef_dictionary/chef.txt"}
  ],
  "cSpell.dictionaries": [
    "chef_dictionary"
  ],
```

### Markdownlint

[Markdownlint](https://github.com/DavidAnson/markdownlint)

### Vale

[Vale](https://docs.errata.ai/vale/about)

## Download the Chef Repositories

Clone the following repositories:

| Product | GitHub Docs Directory |
|---------|-----------------------|
|Chef Automate |https://github.com/chef/automate|
|Chef Habitat |https://github.com/habitat-sh/habitat|
|Chef Infra Client |https://github.com/chef/chef-web-docs|
|Chef Infra Server |https://github.com/chef/chef-server|
|Chef Inspec| https://github.com/inspec/inspec|

For example, you can clone a repo using the GitHub CLI with the command `gh repo clone chef/chef-web-docs`.
