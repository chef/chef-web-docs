#!/bin/bash

# Verify that each Cookstyle YAML file in generated/_vendor/github.com/chef/cookstyle/docs-chef-io/assets/cookstyle
# has a matching Markdown file in generated/generated_content/workstation/cookstyle/cops.

# You can regenerate all the Cookstyle Markdown files by running `cd generated && make build && cd ../`.


set -euo pipefail

dataDir=generated/_vendor/github.com/chef/cookstyle/docs-chef-io/assets/cookstyle/*
LINT_STATUS=0

for file in $dataDir
    do mdFile="${file/.yml/.md}"
    mdFile="${mdFile/cops_/}"
    mdFile="${mdFile/generated\/_vendor\/github.com\/chef\/cookstyle\/docs-chef-io\/assets\/cookstyle/generated/generated_content/workstation/cookstyle/cops}"
    if test ! -f "${mdFile}"; then
        echo "${mdFile} is missing."
        LINT_STATUS=1
    fi
done

if test ! -f "generated/generated_content/workstation/cookstyle/cops/_index.md"; then
    echo "content/workstation/cookstyle/cops.md is missing."
    LINT_STATUS=1
fi

if [ "$LINT_STATUS" == 1 ]; then
    echo -e "\nAt least one Cookstyle Markdown file is missing from generated/generated_content/workstation/cookstyle."
    echo "Regenerate all Cookstyle Markdown files by running 'cd generated && make build && cd ../'."
    exit 1
else
    echo "Success! All Cookstyle Markdown files exist."
    exit 0
fi
