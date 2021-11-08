#!/bin/bash

# Verify that each Cookstyle YAML file in _vendor/github.com/chef/cookstyle/docs-chef-io/data/cookstyle
# has a matching Markdown file in content/workstation/cookstyle.

# You can regenerate all the Cookstyle Markdown files by running `make cookstyle_cops_pages`.
# Individual Cookstyle Markdown pages can be created by running `hugo new -k cookstyle_cop content/workstation/cookstyle/NAME_OF_COOKSTYLE_YAML_FILE.md`.

set -euo pipefail

dataDir=_vendor/github.com/chef/cookstyle/docs-chef-io/data/cookstyle
markdownDir=./content/workstation/cookstyle
LINT_STATUS=0
for file in _vendor/github.com/chef/cookstyle/docs-chef-io/data/cookstyle/*
    do mdFile="${file/.yml/.md}"
    mdFile="${mdFile/cops_/}"
    mdFile="${mdFile/_vendor\/github.com\/chef\/cookstyle\/docs-chef-io\/data\/cookstyle/content/workstation/cookstyle}"
    if test ! -f "${mdFile}"; then
        echo "${mdFile} is missing."
        LINT_STATUS=1
    fi
done

if test ! -f "content/workstation/cookstyle/cops.md"; then
    echo "content/workstation/cookstyle/cops.md is missing."
    LINT_STATUS=1
fi

if [ "$LINT_STATUS" == 1 ]; then
    echo "At least one Cookstyle Markdown file is missing from content/workstation/cookstyle."
    echo "Regenerate all Cookstyle Markdown files by running 'make cookstyle_cops_pages', or make individual Cookstyle Markdown pages"
    echo "by running 'hugo new -k cookstyle_cop content/workstation/cookstyle/NAME_OF_COOKSTYLE_YAML_FILE.md'."
    exit 1
else
    echo "Success! All Cookstyle Markdown files exist."
    exit 0
fi
