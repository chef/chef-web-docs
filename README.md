<!-- markdownlint-disable-file MD002 MD033 MD041-->
This GitHub Repository is the source for the Chef documentation published on [docs.chef.io](https://docs.chef.io/).

The [<https://github.com/chef/chef-web-docs>](https://github.com/chef/chef-web-docs) repository contains:

- Source code for the documentation theme
- Markdown files for much of the Chef Infra Client content
- Configuration files
- Vendored files for documentation from other repositories that are presented on docs.chef.io.

This README.md covers information on building and previewing documentation. The House Style Guide and more detailed information about Hugo and our documentation tools are published in the documentation:

- [Basics](https://docs.chef.io/style_guide/). (Similar to content on this page)
- [Chef House Style](https://docs.chef.io/style_guide/chef_house/)
- [Hugo](https://docs.chef.io/style_guide/hugo/)
- [Markdown](https://docs.chef.io/style_guide/markdown/)
- [Content Reuse and Shortcodes](https://docs.chef.io/style_guide/reuse/)
- [Tools](https://docs.chef.io/style_guide/tools/)

## Distributed Documentation

The Chef documentation source is highly distributed and depends on [Hugo modules](https://gohugo.io/hugo-modules/) to pull in documentation from other Chef repositories. The content from those repositories is [vendored](#hugo-vendoring) in chef-web-docs.

To make changes to the content in those repositories, submit pull requests to the appropriate repository. Do not submit pull requests to the vendored files in chef-web-docs. We will update those changes after they're merged or after a new version of a product is released.

## GitHub Repositories with Documentation

- Chef Automate: [<https://github.com/chef/automate/tree/main/components/docs-chef-io>](https://github.com/chef/automate/tree/main/components/docs-chef-io
)
- Chef Infra Server: [<https://github.com/chef/chef-server/tree/main/docs-chef-io>](https://github.com/chef/chef-server/tree/main/docs-chef-io)
- Chef Workstation [<https://github.com/chef/chef-workstation/tree/main/docs-chef-io>](https://github.com/chef/chef-workstation/tree/main/docs-chef-io)
- Chef Desktop [<https://github.com/chef/desktop-config/tree/main/docs-chef-io>](https://github.com/chef/desktop-config/tree/main/docs-chef-io
)
- Chef Supermarket [<https://github.com/chef/supermarket/tree/main/docs-chef-io>](https://github.com/chef/supermarket/tree/main/docs-chef-io)
- Chef Habitat [<https://github.com/habitat-sh/habitat/tree/main/components/docs-chef-io>](https://github.com/habitat-sh/habitat/tree/main/components/docs-chef-io
)
- Chef InSpec [<https://github.com/inspec/inspec/tree/main/docs-chef-io>](https://github.com/inspec/inspec/tree/main/docs-chef-io
)
- Chef InSpec AWS [<https://github.com/inspec/inspec-aws/tree/main/docs-chef-io>](https://github.com/inspec/inspec-aws/tree/main/docs-chef-io
)
- Chef InSpec Azure [<https://github.com/inspec/inspec-azure/tree/main/docs-chef-io>](https://github.com/inspec/inspec-azure/tree/main/docs-chef-io
)
- Chef InSpec AliCloud [<https://github.com/inspec/inspec-alicloud/tree/main/docs-chef-io>](https://github.com/inspec/inspec-alicloud/tree/main/docs-chef-io
)
- Chef InSpec Habitat [<https://github.com/inspec/inspec-habitat/tree/main/docs-chef-io>](https://github.com/inspec/inspec-habitat/tree/main/docs-chef-io
)

## The Fastest Way to Contribute

The fastest way to change the documentation is to edit a page on the
GitHub website using the GitHub UI.

To perform edits using the GitHub UI, click on the `[edit on GitHub]` link at
the top of the page that you want to edit. The link takes you to that topic's GitHub
page. In GitHub, click on the pencil icon and make your changes. You can preview
how they'll look right on the page ("Preview Changes" tab).

We also require contributors to include their [DCO signoff](https://github.com/chef/chef/blob/main/CONTRIBUTING.md#developer-certification-of-origin-dco)
in the comment section of every pull request, except for obvious fixes. You can
add your DCO signoff to the comments by including `Signed-off-by:`, followed by
your name and email address, like this:

`Signed-off-by: Haris Shefu <hshefu@example.com>`

See our [blog post](https://blog.chef.io/introducing-developer-certificate-of-origin/)
for more information about the DCO and why we require it.

After you've added your DCO signoff, add a comment about your proposed change,
then click on the "Propose file change" button at the bottom of the page and
confirm your pull request. The CI system will do some checks and add a comment
to your PR with the results.

The Chef Documentation Team can normally merge pull requests within seven days. We'll
fix build errors before we merge, so you do not have to
worry about passing all of the CI checks, but it might add an extra
few days. The important part is submitting your change.

## Local Development Environment

The Chef Documentation website is built using:

- [Hugo](https://gohugo.io/) 0.104.3 or higher
- [Node](https://www.nodejs.com) 10.0.0 or higher
- [NPM](https://www.npmjs.com/) 5.6.0 or higher
- [Go](https://golang.org/dl/) 1.12 or higher

To install Hugo, NPM, and Go on Windows and macOS:

- On macOS run: `brew install hugo node go`
- On Windows run: `choco install hugo-extended nodejs golang`

To install Hugo on Ubuntu, run:

- `apt install -y build-essential`
- `snap install node --classic --channel=12`
- `snap install hugo --channel=extended`

### Troubleshooting Your Development Environment

To clean your local development environment:

- Run `make clean` to delete the sass files, javascript, and fonts. These will
  be rebuilt the next time you run `make serve`.

- Run `make clean_all` to delete the node modules used to build this site
  in addition to the functions of `make clean` described above. Those node
  modules will be reinstalled the next time you run `make serve`.

## Build and Preview the Docs

There are two ways to preview documentation:

- Submit a PR and look at the Netlify preview.
- Build the documentation locally.

### Submit a PR and Look at the Netlify Preview

We have configured Netlify to generate deploy previews of pull requests to the chef-web-docs repository. Netlify will add a comment to the PR with a link to the deploy preview after it finishes building the preview.

Netlify will automatically build deploy previews for PRs from contributors who are members of the Chef GitHub organization. The Documentation Team can manually tell Netlify to build previews from contributors who are not members of the Chef GitHub organization.

### Build and Preview the Docs Locally

- Run `make serve`
- go to [http://localhost:1313](http://localhost:1313)

Note that this repository consumes content from other repositories using Hugo modules.
That content is stored in the `_vendor` directory. `make serve` uses the
content in your local `_vendor` directory instead of from its source GitHub repository
OR from a local copy of a repository.

#### Build and Preview the Docs from the Source Repositories

- Run `make serve_ignore_vendor`

Some Chef documentation is stored in private repositories so this option is only
available to Progress Chef employees.

## Hugo Vendoring

[Vendoring](https://gohugo.io/commands/hugo_mod_vendor/) stores all of the module content
from other repositories in the `_vendor` directory at the commit specified by
the `go.mod` file. When Hugo builds the documentation, it will grab content from
the `_vendor` directory instead of the original repository OR a local copy of a
that repository. To see which commits the vendored files reference, see the
`_vendor/modules.txt` file.

To vendor the modules in chef-web-docs, run `hugo mod vendor`.

To update the vendored modules, first update the [Hugo module(s)](#update-hugo-modules),
then run `hugo mod vendor`.

To ignore the vendored files in a Hugo build, run `make serve_ignore_vendor`. This
is the same as `make serve` except it adds the `--ignoreVendor` flag. This will
build the documentation from the GitHub repositories or from a local copy of a repository
if the `go.mod` file specifies pulling content from a local repository. (see above)

### Update Hugo Modules

Hugo modules are pinned to a particular commit of the master branch in their repository.
If you look in the `go.mod` and `go.sum` files, you'll notice that each repository
specifies a git commit timestamp and SHA.

To update a particular repo, run:

```bash
hugo mod get github.com/chef/repo_to_update/subdirectory
hugo mod clean
```

Then [vendor](#hugo-vendoring) the documentation:

```bash
hugo mod vendor
```

For example, to update the chef-workstation repository:

```bash
hugo mod get github.com/chef/chef-workstation/docs-chef-io
hugo mod clean
hugo mod vendor
```

This will update that repository to the most recent commit.

You can also update a module to a commit version number. For example:

```go
hugo mod get github.com/chef/chef-workstation/docs-chef-io@20.6.62
hugo mod clean
hugo mod vendor
```

And you can update a module to a Git commit. For example:

```go
hugo mod get github.com/chef/chef-workstation/docs-chef-io@0ad84dd5fa8
hugo mod clean
hugo mod vendor
```

To update all Hugo modules at the same time, run:

```go
hugo mod get -u
hugo mod clean
hugo mod vendor
```

The `hugo mod clean` command removes references to commits in the
`go.mod` and `go.sum` files that are no longer relevant.

See Hugo's [documentation](https://gohugo.io/hugo-modules/use-modules/#update-modules)
for additional information about updating Hugo Modules.

### What if Hugo Does not Want to Update a Module

Sometimes Hugo and Git can be a bit difficult and will not update a module cleanly or will leave
references to older commits of a module in the go.sum file.

If you get an error indicating that a Git cannot find a repository that's already
been added as a module, try restarting your computer.

If you are still having trouble, try rebuilding the go.mod and go.sum files:

1. Delete the go.mod and go.sum files.
1. Re-initialize the Hugo modules, `hugo mod init github.com/chef/chef-web-docs`
   This will generate a new, blank go.mod file.
1. Update the references to the other GitHub repositories, `hugo mod get -u`.
1. The previous step will update all modules to the latest commit of their source
   repositories.
   If you do not want that, look at the git history of those files and manually edit the
   go.mod and go.sum files to keep the older commits for the modules that
   you do not want to update.
1. Run `hugo mod tidy`. This probably will not do anything on newly initialized go.mod
   and go.sum files, but it cannot hurt either.
1. Vendor the modules in chef-web-docs, `hugo mod vendor`.

## Release Notes

Release notes are added to release notes pages using Hugo's [`resource.getRemote` function](https://gohugo.io/hugo-pipes/introduction/#get-resource-with-resourcesget-and-resourcesgetremote) and content from [https://omnitruck.chef](omnitruck.chef.io) and [https://packages.chef.io](packages.chef.io).

Chef Automate release versions, release dates, and links to release note Markdown files come from [https://packages.chef.io/releases/current/automate.json](https://packages.chef.io/releases/current/automate.json).

Release versions for Chef habitat come from `https://api.github.com/repos/habitat-sh/habitat/releases`.

Release versions for Chef InSpec Cloud resources comes from `_vendor/github.com/inspec/inspec-<PLATFORM>/docs-chef-io/assets/release-notes/inspec-<PLATFORM>/release-dates.json`.

Release versions for all other Chef products come from `https://omnitruck.chef.io/stable/<PRODUCT>/versions/all`.

Each release note page comes from a Markdown file from `https://packages.chef.io/release-notes/<PRODUCT>/<VERSION>.md`.

If a release note Markdown file is not returned from packages.chef.io, the release note for that version will show the text, "This release does not have any release notes."

### Previewing Release Notes Locally

Release note pages are only generated in the production environment. Running `make serve` will not build any of the content in the release note pages.

Run `make production` to build and preview the release notes.

Run `make clean_all` to purge locally cached release note files.

### Adding Release Note Pages

To add a release notes page to chef-web-docs, add the following to a Markdown page:

```toml
release_notes = "<CHEF_PRODUCT>"
product = "<CHEF_PRODUCT>"
layout = "release_notes"
toc_layout = "release_notes_toc"
```

The `<CHEF_PRODUCT>` value comes from the Product Key in the [Product Matrix](https://github.com/chef/mixlib-install/blob/main/PRODUCT_MATRIX.md).

Any content included in the release notes Markdown file will be included at the top of the page and the release notes will be appended below.

## Documentation Snapshots

The previous scoped doc sets that were found on [docs.chef.io](https://docs.chef.io/release/) are no longer available in this repo. Instead, those doc sets are located at [Chef Docs Archive](https://docs-archive.chef.io/). The index page on the docs archive site provides links to them. The doc sets retain their unique left nav and can be used to view content at a particular point in time for a given release. In the future, snapshots will be added for major releases of products/projects or for products/projects/components that are no longer supported.

## Archive of pre-2016 commit history

The commit history of this repo before February 12, 2016 has been archived to the [chef-web-docs-2016 repo](https://github.com/chef-boneyard/chef-web-docs-2016) to save space. No changes to the archive repo will be merged; it is just for historical purposes.

## Sending Feedback

We love getting feedback. You can use:

- Email --- Send an email to chef-docs@progress.com for documentation bugs,
  ideas, thoughts, and suggestions. This email address is not a
  support email address, however. If you need support, contact Chef
  support.
- Pull request --- Submit a PR to this repo using either of the two
  methods described above.
- Use [chef-web-docs issues](https://github.com/chef/chef-web-docs/issues) for docs feature requests and minor docs bugs.
- Submit issues to product repositories for "important" documentation bugs that may need visibility among a
  larger group, especially in situations where a doc bug may also
  surface a product bug.
  - [chef/chef GitHub Issues](https://github.com/chef/chef/issues) --- For issues specific to Chef Infra Client.
  - [chef/automate GitHub Issues](https://github.com/chef/automate/issues) --- For issues specific to Chef Automate.
  - [chef/chef-server GitHub Issues](https://github.com/chef/chef-server/issues) --- For issues specific to Chef Infra Server.
  - [chef/chef-workstation GitHub Issues](https://github.com/chef-workstation/chef/issues) --- For issues specific to Chef Workstation.
  - [chef/supermarket GitHub Issues](https://github.com/chef/supermarket/issues) --- For issues specific to Chef Supermarket.
  - [habitat-sh/habitat GitHub Issues](https://github.com/habitat-sh/habitat/issues) --- For issues specific to Chef Habitat.
  - [inspec/inspec GitHub Issues](https://github.com/inspec/inspec/issues) --- For issues specific to Chef InSpec.
  - [inspec/inspec-aws GitHub Issues](https://github.com/inspec/inspec-aws/issues) --- For issues specific to Chef InSpec AWS cloud resources.
  - [inspec/inspec-azure GitHub Issues](https://github.com/inspec/inspec-azure/issues) --- For issues specific to Chef InSpec Azure cloud resources.
  - [inspec/inspec-habitat GitHub Issues](https://github.com/inspec/inspec-habitat/issues) --- For issues specific to Chef InSpec Habitat cloud resources.
  - [inspec/inspec-alicloud GitHub Issues](https://github.com/inspec/inspec-alicloud/issues) --- For issues specific to Chef InSpec Alibaba cloud resources.
- [Chef Discourse](https://discourse.chef.io/) --- This is a great place to interact with Chef and others.
