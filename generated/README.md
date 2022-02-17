This directory contains scripts and configuration files that generate Markdown files in the `generated/generated_content` directory. Basically this is a second Hugo project inside of chef-web-docs.

## Generate Cookstyle Cops Documentation

From the `generated` directory, run `make build`.

This will regenerate all the Cookstyle cops Markdown pages in `generated/generated_content`.

## Update Cookstyle Cops Documentation

From the `generated` directory, run `make update_cookstyle_cops`

This will:
1. Delete all existing Cookstyle cops documentation in `generated/generated_content`.
2. Update the chef/cookstyle Hugo module in `generated/go.mod` to the latest commit of the `chef/cookstyle` repo.
3. Rebuild the Cookstyle cops Markdown files in `generated/generated_content/workstation`.

## How It Works

When you run `hugo` from `chef-web-docs/generated`, Hugo will execute the `generated/layouts/index.html` layout. That layout calls two partials in `generated/layouts/partials` which read YAML files in `generated/_vendor` and will output Markdown files in the `generated/generated_content` directory.

## chef-web-docs

Hugo is configured in chef-web-docs to mount generated_content in `generated/generated_content/workstation` to `content/workstation`. See the `config/_default/module.toml` configuration file.

## More Info

This setup is based on a [blog post and example project](https://www.thenewdynamic.com/article/toward-using-a-headless-cms-with-hugo-part-2-building-from-remote-api/) from [The New Dynamic](https://www.thenewdynamic.com).
