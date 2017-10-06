# chef-web-docs

This repo is the source of the Chef reference documentation located at
https://docs.chef.io/

On October 23, 2016, it became easier to contribute to Chef reference
documentation. For each topic, you now only have to make edits to a
single file that looks a lot like the final HTML.

## The fastest way to contribute

If you spot something in the docs that needs to be fixed, the fastest
way to get the change in is to edit the file on the GitHub web
site. To do this, click on the `[edit on GitHub]` link at the top of
the page you want to edit. The link takes you to that topic's GitHub
page. In GitHub, click on the pencil icon and make your changes. You
can preview how they'll look right on the page ("Preview Changes"
tab).

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

## The next fastest way

If your change involves edits to multiple topics, or if you contribute
frequently, you'll want to fork this repo in GitHub, clone it on your
workstation, and make pull requests from commits you push to your
forked repo. After you fork `chef/chef-web-docs` using the GitHub web
interface, clone the forked repo to your workstation, following these [instructions](https://docs.chef.io/community_contributions.html#use-git).

Contributing this way requires some set-up, but once you're done, you can contribute 
frequently and from the comfort of your own GitHub repo. Our docs have three major dependencies: 

  1. We currently require version 1.6.2 of [Sphinx](http://sphinx-doc.org/). 
  2. The requirements.txt file referenced below pins Sphinx and its dependencies to versions that are compatible with each other. 
  3. You may also need to install Python, depending on your system.
  4. You may also need to install Ruby, depending on your system.

After making your changes but before submitting a PR, run the shell
command `make` at the root of your local `chef-web-docs` repo to check for errors and build a local version of
the doc set in HTML for testing. Before running `make` for the first time, you'll need to
install Sphinx, the documentation generator, possibly using `sudo`:

```bash
  pip install -r requirements.txt
```

> Note: The default `make` target is `docs`. This is the target that creates the appropriate `build` directory on your local machine and references in the source files in the `chef_master/source` directory of your local repo.


The docs build in a minute or two. To
view the local version you built, you have two options:

* Open the file `build/<filename>` in your browser 
* Use a local web server like the `SimpleHTTPServer` python module

Viewing your content using the `SimpleHTTPServer` module allows you to navigate through the documentation as if you were browsing it on https://docs.chef.io. To use the `SimpleHTTPServer` module:

1. Navigate to the `build` directory.
2. Run `python -m SimpleHTTPServer`. After the server starts up, connect to your docs through your loopback IP address (http://127.0.0.1:8000).

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

* Email --- Send an email to docs@chef.io for documentation bugs,
  ideas, thoughts, and suggestions. This email address is not a
  support email address, however. If you need support, contact Chef
  support.
* Pull request --- Submit a PR to this repo using either of the two
  methods described above.
* GitHub issues --- Use the https://github.com/chef/chef/issues page
  for issues specific to Chef itself. This is a good place for
  "important" documentation bugs that may need visibility among a
  larger group, especially in situations where a doc bug may also
  surface a product bug. You can also use
  [chef-web-docs issues](https://github.com/chef/chef-web-docs/issues),
  especially for docs feature requests and minor docs bugs.
* https://discourse.chef.io/ --- This is a great place to interact with Chef and others.

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

## Questions?

Open an [issue](https://github.com/chef/chef-web-docs/issues) and
ask. Or send email to docs@chef.io.
