+++
title = "Docs Style"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/style_guide.html"]
product = []

[menu]
  [menu.overview]
    title = "Docs Style"
    identifier = "overview/style/style_index"
    parent = "overview/style"
    weight = 80
+++

The Chef Documentation is online at [docs.chef.io](https://docs.chef.io).
Our documentation is open source and we follow a [docs as code](https://www.docslikecode.com/) methodology.
Our workflow is based in GitHub, we write in Markdown, and we use Hugo as our static site generator.

Any community member can make or suggest a documentation change through pull request (PR) or issue in a documentation repository.

## Documentation Repositories

Our main repository (repo, for short) for [docs.chef.io](https://docs.chef.io) is called [chef-web-docs](https://github.com/chef/chef-web-docs). This repo contains the files for Chef Infra Client and the Hugo files for our front-end theme, templates, and shortcodes. The Chef documentation is located in: `https://github.com/chef/chef-web-docs`

- The `chef-web-docs` repo contains a `content` directory which holds most the Markdown files in the doc set.
- The `static/images` directory stores the image files used in the docs.
- The `config.toml` tells Hugo how to build the navigation menus and contains other Hugo settings. Don't modify this file.

### Repository Locations

We try to keep our documentation source as close to the code as possible, which means that our documentation files are distributed across several product repositories.

<!-- markdownlint-disable -->
| Product | GitHub Docs Directory |
|---------|-----------------------|
|Chef Automate |https://github.com/chef/automate/tree/main/components/docs-chef-io|
|Chef Habitat |https://github.com/habitat-sh/habitat/tree/main/components/docs-chef-io|
|Chef Infra Client |https://github.com/chef/chef-web-docs|
|Chef Infra Server |https://github.com/chef/chef-server/tree/main/docs-chef-io|
|Chef Inspec| https://github.com/inspec/inspec/tree/main/docs-chef-io|
<!-- markdownlint-enable -->
## How to Make a Change

### Finding the Right Repository

The easiest way to find the location of the source file is to select the `Edit on GitHub` link at the top of every documentation file in your browser.

Selecting `Edit on GitHub`
![Edit On GitHub](/images/edit_on_github.png)

Opens the related documentation file in the correct repository.

### Suggest a Change

You can open a change PR directly in the browser by selecting the pen icon in the documentation file--but you will need to add your DCO directly in the commit message.

which is circled in red in this image.
![File in Repository](/images/file_in_repo.png)

### DCO Sign-off

Chef Software requires all contributors to include a [Developer Certificate of Origin](https://developercertificate.org/) (DCO) sign-off with their pull request as long as the pull request does not fall under the [Obvious Fix](#obvious-fix) rule. This attests that you have the right to submit the work that you are contributing in your pull request.

See this [blog post](https://blog.chef.io/2016/09/19/introducing-developer-certificate-of-origin/) to understand why Chef started using the DCO signoff.

For more information, review our [full DCO signoff policy](https://github.com/chef/chef/blob/main/CONTRIBUTING.md#developer-certification-of-origin-dco).

A proper DCO sign-off looks like:

`Signed-off-by: Tamira Bucatar <tbucatar@example.com>`

Your commit message should look something like:

![Add DCO](/images/add_DCO.png)

Select `propose changes` and finish opening your PR.

You can add a DCO signoff to your pull request by adding it to the text of your commit message, or by using the `-s` or `--signoff` option when you make a commit.

#### Add a DCO to a PR

If you forget to add a DCO sign-off before submitting a pull request, you can amend your commit from the command line with the Git CLI by entering `git commit --amend --signoff`. After that you'll need to force push your commit to GitHub using the command `git push -f`.

### Obvious Fix--No DCO Required

Small contributions, such as fixing spelling errors, where the content is small enough to not be considered intellectual property, can be submitted without signing the contribution for the DCO.

Changes that fall under our Obvious Fix policy include:

- Spelling / grammar fixes
- Typo correction, white space and formatting changes
- Comment clean up
- Bug fixes that change default return values or error codes stored in constants
- Adding logging messages or debugging output
- Changes to 'metadata' files like Gemfile, .gitignore, build scripts, etc.

To invoke the Obvious Fix rule, simply add `Obvious Fix.` to your commit message.

For more information, see our [Obvious Fix policy](https://github.com/chef/chef/blob/main/CONTRIBUTING.md#chef-obvious-fix-policy).

## Preview the Build

## Deleting Pages or Making New Pages

Contact the documentation team if you would like to suggest adding or removing pages.

## Contact

See our [feedback](/feedback/) page if you have any questions or comments for the documentation team.
