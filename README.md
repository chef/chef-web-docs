# chef-web-docs

This repo is the source of the Chef reference documentation located at
https://docs.chef.io/

## The fastest way to contribute

If you spot something in the docs that needs to be fixed, the fastest way to get in the change is to edit the file on the GitHub website using the GitHub UI. PRs submitted through remote forks are not currently enabled as they do not work with our CI system.

To perform edits using the GitHub UI, click on the `[edit on GitHub]` link at the top ofthe page you want to edit. The link takes you to that topic's GitHub page. In GitHub, click on the pencil icon and make your changes. You can preview how they'll look right on the page ("Preview Changes" tab).

We no longer use "swaps" and include files, so you'll be able to see
all of text in one place for each topic. If you need tips on the
source language, check out these
[instructions](https://docs.chef.io/style_guide.html).

When you're done editing, press the "Propose file change" button at
the bottom of the page and confirm your pull request. The CI system
will do some checks and add a comment to your PR with the results.

The Chef docs team can normally merge pull requests within a day or
two. We'll fix build errors before we merge, so you don't have to
worry about passing all of the CI checks, but it might add an extra
few days. The important part is submitting your change.

## Local Development Environment

The docs website is built using Sphinx in a local docker container
to minimize python environment issues.
You'll need a minimum version of Docker 18.03 installed and running.

To build the docs:

- Run `make docker-build`

To (build and) preview locally:

- Run `make docker-preview`
- go to http://localhost:8000

To check dtags:

- Run `make docker-dtags` (this will drop you in a shell at the correct location)
- cd to the appropriate directories
- run `dtags replicate <options>` as needed (see the [readme](doctools/dtags_readme.md) and [help](doctools/dtags_help.md) for more information)

To clean your local development environment:

- Run `make clean`

If you need tips on the source language for the docs, check out the
[instructions](https://docs.chef.io/style_guide.html). We use a subset
of restructuredText that's similar in scope to markdown.

## Tagged regions

We studied how to make contributing to this doc set as easy as
possible. We ended up choosing an approach that uses tagged regions
delimited by `.. tag` and `.. end_tag` lines to denote shared blocks
of text. The tagged regions act like include files, but they're
visible inline and therefore easier to edit.

For more information about how tagged regions work and how our new
`dtags` tool helps manage them, see the
[`dtags` README file](doctools/dtags_readme.md) and
[`dtags` help](doctools/dtags_help.md).

## Sending feedback

We love getting feedback. You can use:

- Email --- Send an email to docs@chef.io for documentation bugs,
  ideas, thoughts, and suggestions. This email address is not a
  support email address, however. If you need support, contact Chef
  support.
- Pull request --- Submit a PR to this repo using either of the two
  methods described above.
- GitHub issues --- Use the https://github.com/chef/chef/issues page
  for issues specific to Chef itself. This is a good place for
  "important" documentation bugs that may need visibility among a
  larger group, especially in situations where a doc bug may also
  surface a product bug. You can also use
  [chef-web-docs issues](https://github.com/chef/chef-web-docs/issues),
  especially for docs feature requests and minor docs bugs.
- https://discourse.chef.io/ --- This is a great place to interact with Chef and others.

## License

[Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/)

## Documentation snapshots

The previous scoped doc sets that were found off of https://docs.chef.io/release/ are no longer available in this repo. Instead,
those doc sets are located at https://docs-archive.chef.io/. The index page on the docs archive site provides links to them. The doc sets retain their unique
left nav and can be used to view content at a particular point in time for a given release. In the future, snapshots
will be added for major releases of products/projects or for products/projects/components that are no longer supported.

## Archive of pre-2016 commit history

Commit history of this repo prior to February 12, 2016 has been
archived to the chef/chef-web-docs-2016 repo to save space. No changes
to the archive repo will be merged; it's just for historical purposes.

## Questions

Open an [issue](https://github.com/chef/chef-web-docs/issues) and
ask. Or send email to docs@chef.io.
