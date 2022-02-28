<!-- markdownlint-disable-file MD002 MD033 MD041-->
This GitHub Repository is the source for the Chef documentation located published on [docs.chef.io](https://docs.chef.io/).

The [<https://github.com/chef/chef-web-docs>](https://github.com/chef/chef-web-docs) repository contains:

- Source code for the documentation theme
- Markdown files for much of the Chef Infra Client content
- Configuration files
- Vendored files for documentation from other repositories that are presented on docs.chef.io.

This README.md covers information on building and previewing documentation. The House Style Guide and more detailed information about Hugo and our documentation tools are published in the documentation:

- [Basics](https://docs.chef.io/style_index/). (Similar to content on this page)
- [Chef House Style](https://docs.chef.io/style_house/)
- [Tools](https://docs.chef.io/style_tools/)
- [Hugo](https://docs.chef.io/style_hugo/)
- [Markdown](https://docs.chef.io/style_markdown/)
- [Content Reuse and Shortcodes](https://docs.chef.io/style_reuse/)

## Distributed documentation

The Chef documentation source is highly distributed and depends on [Hugo modules](https://gohugo.io/hugo-modules/) to pull in documentation from other Chef repositories. The content from those repositories is [vendored](#hugo-vendoring) in chef-web-docs.

To make changes to the content in those repositories, submit pull requests to the appropriate repository. Do not submit pull requests to the vendored files in chef-web-docs. We will update those changes after they're merged or after a new version of a product is released.

## GitHub repositories with documentation

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

## The fastest way to contribute

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
fix build errors before we merge, so you don't have to
worry about passing all of the CI checks, but it might add an extra
few days. The important part is submitting your change.

## Local Development Environment

The Chef Documentation website is built using:

- [Hugo](https://gohugo.io/) 0.61 or higher
- [Node](https://www.nodejs.com) 10.0.0 or higher
- [NPM](https://www.npmjs.com/) 5.6.0 or higher
- [Go](https://golang.org/dl/) 1.12 or higher

To install Hugo, NPM, and Go on Windows and macOS:

- On macOS run: `brew install hugo node go`
- On Windows run: `choco install hugo nodejs golang`

To install Hugo on Ubuntu, run:

- `apt install -y build-essential`
- `snap install node --classic --channel=12`
- `snap install hugo --channel=extended`

### Markdown

Hugo uses [Goldmark](https://github.com/yuin/goldmark) which is a
superset of Markdown that includes GitHub styled tables, task lists, and
definition lists.

### Troubleshooting your Dev Environment

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

We've configured Netlify to generate deploy previews of pull requests to the chef-web-docs repository. Netlify will add a comment to the PR with a link to the deploy preview after it finishes building the preview.

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

```go
hugo mod get github.com/chef/repo_to_update/subdirectory
hugo mod tidy
```

Then [vendor](#hugo-vendoring) the documentation:

```go
hugo mod vendor
```

For example, to update the chef-workstation repository:

```go
hugo mod get github.com/chef/chef-workstation/docs-chef-io
hugo mod tidy
hugo mod vendor
```

This will update that repository to the most recent commit.

You can also update a module to a commit version number. For example:

```go
hugo mod get github.com/chef/chef-workstation/docs-chef-io@20.6.62
hugo mod tidy
hugo mod vendor
```

To update all Hugo modules at the same time, run:

```go
hugo mod get -u
hugo mod tidy
hugo mod vendor
```

The `hugo mod tidy` command removes references to commits in the
`go.mod` and `go.sum` files that are no longer relevant.

Sometimes the `go.sum` file gets a little out of control and `hugo mod tidy` won't
clean it up. Each repository listed in the `go.mod` file should have two lines
in the `go.sum` file. If it has more than that and `hugo mod tidy` doesn't remove them,
delete the `go.sum` file and rebuild it with `hugo mod get -u`.

See Hugo's [documentation](https://gohugo.io/hugo-modules/use-modules/#update-modules)
for additional information about updating Hugo Modules.

#### go.sum File

The go.sum file should reference only one commit for each repository that is added
as a module to chef-web-docs. Each module and commit in the go.sum file will take
two or three lines. For example, the `chef/chef-workstation` repository documentation will
look like this:

```go
github.com/chef/chef-workstation/docs-chef-io v0.0.0-20200625161326-f43898a8e6c0 h1:MTVSgikrlIqceXki6uVwbf+iCVPwkpxsh1ERseRG31g=
github.com/chef/chef-workstation/docs-chef-io v0.0.0-20200625161326-f43898a8e6c0/go.mod h1:rktT78z3KaWu7A+wf1g6KmYszrwn6Y3o3IFlTg8OpQg=
```

If there are references to older commits, delete those lines.

The `hugo mod tidy` command should remove those lines, but sometimes it doesn't.

The commit SHA and timestamp in the go.sum file should match the SHA and timestamp
in the go.mod file.

### What if Hugo Doesn't Want to Update a Module

Sometimes Hugo and Git can be a bit difficult and won't update a module cleanly or will leave
references to older commits of a module in the go.sum file.

If you get an error indicating that a Git can't find a repository that's already
been added as a module, try restarting your computer.

If you are still having trouble, try rebuilding the go.mod and go.sum files:

1. Delete the go.mod and go.sum files.
1. Re-initialize the Hugo modules, `hugo mod init github.com/chef/chef-web-docs`
   This will generate a new, blank go.mod file.
1. Update the references to the other GitHub repositories, `hugo mod get -u`.
1. The previous step will update all modules to the latest commit of their source
   repositories.
   If you don't want that, look at the git history of those files and manually edit the
   go.mod and go.sum files to keep the older commits for the modules that
   you don't want to update.
1. Run `hugo mod tidy`. This probably won't do anything on newly initialized go.mod
   and go.sum files, but it can't hurt either.
1. Vendor the modules in chef-web-docs, `hugo mod vendor`.

## Shortcodes

Shortcodes are simple snippets of code that can be used to modify a Markdown
page by adding content or changing the appearance of content in a page. See
Hugo's [shortcode documentation](https://gohugo.io/content-management/shortcodes/)
for general information about shortcodes.

We primarily use shortcodes in two ways:

- adding reusable text
- highlighting blocks of text in notes or warnings to warn users or
provide additional important information

### Reusable Text

There are often cases where we want to maintain blocks of text that are identical
from one page to the next. In those cases, we add that text, formatted in Markdown,
to a shortcode file located in `chef-web-docs/themes/docs-new/layouts/shortcodes`.

To add that shortcode to a page in `chef-web-docs/content`, add the file name,
minus the .md suffix, wrapped in double curly braces and percent symbols to
the location in the Markdown page where you want that text included. For example,
if you want to add the text in `shortcode_file_name.md` to a page, add
`{{% shortcode_file_name %}}` to the text of that page and it will appear when
Hugo rebuilds the documentation.

#### Shortcodes in Lists

Hugo doesn't handle shortcodes that are indented in a list item properly. It interprets the text of the shortcode as a code block. More complicated shortcodes with code blocks, notes, additional list items, or other formatting look pretty bad. We've created a simple shortcode for handling shortcodes in lists or definition lists called `readFile_shortcode`.

To include a shortcode in a list or definition list, just add its file name to the `file` parameter of `readFile_shortcode`.

For example, if you wanted to add `shortcode_file_name.md` to a list:

```md
1.  Here is some text introducing the shortcode, but it's not necessary.

    {{< readFile_shortcode file="shortcode_file_name.md" >}}
```

### Highlighting Blocks of Text

We also use shortcodes to highlight text in notes, warnings or danger notices. These should be used sparingly especially danger notices or warnings. Wrap text that you want in a note using opening and closing shortcode notation. For example,

```text
{{< note >}}

Note text that gives the user additional important information.

{{< /note >}}
```

To add a warning or danger, replace the word `note` with `warning` or `danger` in the example above.

#### Notes in Lists

Hugo doesn't handle shortcodes that are indented in lists well, which includes the `note`, `warning`, and `danger` shortcodes. It interprets the indented text that's inside the admonition as a code block when it should be interpreted as Markdown.

To resolve this problem, there's a `spaces` parameter that can be added to the Note, Warning, and Danger shortcodes. The value of spaces should be set to the number of spaces that the note is indented.

For example:

```text
This is a list:

- List item.

    {{< note spaces=4 >}}

    Text that gives the user additional important information about that list item.

    {{< /note >}}
```

This parameter also works on Danger and Warning shortcodes.

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
release_notes = "<CHEF_PRODUCT>".
layout = "release_notes"
toc_layout = "release_notes_toc"
```

The `<CHEF_PRODUCT>` value comes from the Product Key in the [Product Matrix](https://github.com/chef/mixlib-install/blob/main/PRODUCT_MATRIX.md).

Any content included in the release notes Markdown file will be included at the top of the page and the release notes will be appended below.

## Sending Feedback

We love getting feedback. You can use:

- Email --- Send an email to docs@chef.io for documentation bugs,
  ideas, thoughts, and suggestions. This email address is not a
  support email address, however. If you need support, contact Chef
  support.
- Pull request --- Submit a PR to this repo using either of the two
  methods described above.
- GitHub issues --- Use the [GitHub Issues](https://github.com/chef/chef/issues)
  page for issues specific to Chef Infra itself. This is a good place for
  "important" documentation bugs that may need visibility among a
  larger group, especially in situations where a doc bug may also
  surface a product bug. You can also use
  [chef-web-docs issues](https://github.com/chef/chef-web-docs/issues),
  especially for docs feature requests and minor docs bugs.
- [Chef Discourse](https://discourse.chef.io/) --- This is a great place to interact with Chef and others.

## Documentation Snapshots

The previous scoped doc sets that were found on [docs.chef.io](https://docs.chef.io/release/) are no longer available in this repo. Instead, those doc sets are located at [Chef Docs Archive](https://docs-archive.chef.io/). The index page on the docs archive site provides links to them. The doc sets retain their unique left nav and can be used to view content at a particular point in time for a given release. In the future, snapshots will be added for major releases of products/projects or for products/projects/components that are no longer supported.

## Archive of pre-2016 commit history

The commit history of this repo before February 12, 2016 has been archived to the [chef-web-docs-2016 repo](https://github.com/chef-boneyard/chef-web-docs-2016) to save space. No changes to the archive repo will be merged; it's just for historical purposes.

## Questions

If you need tips for making contributions to our docs, check out the [instructions](https://docs.chef.io/style_guide/).

If you see an error, open an [issue](https://github.com/chef/chef-web-docs/issues) or submit a pull request.

If you have a question, send an email to docs@chef.io.
