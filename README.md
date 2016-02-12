# chef-docs

The source of the Chef documentation, located at https://docs.chef.io/

This README focuses on people who want to contribute to the Chef documentation.

## Sending Feedback

There are several ways to get feedback about Chef documentation:

1. Email --- Send an email to docs@chef.io for documentation bugs, ideas, thoughts, and suggestions. Typos and little errors and quick fixes will be fixed quickly and without fuss. This email address is not a support email address, however.
2. Github issues --- Use the https://github.com/chef/chef/issues page for issues specific to Chef itself. Any documentation bug filed here will make its way to the documentation. This is a good place for "important" documentation bugs that may need visibility among a larger group, especially in situations where a doc bug may also surface a product bug.
3. Pull request and/or issue -- The documentation repository is here: https://github.com/chef/chef-web-docs. A CLA is not required to submit pull requests to this repo. If you are wondering what is going on in that repository, in terms of structure and what-goes-where, send an email to docs@chef.io.
4. chef@lists.opscode.com --- Improvements to the documentation are made because of conversations that happen on this mailing list. That said, relying solely on the mailing list is the least effective way to get feedback to Chef about the documentation.

Thanks in advance for any feedback you choose to send.



## Getting Started

Sphinx is the authoring tool: http://sphinx-doc.org/

reStructuredText (RST) is the authoring format. Only a subset of the formatting options are used, plus there are some specific approaches to what type of formatting goes where, so please review the style guide: https://docs.chef.io/style_guide.html

There are several ways to provide feedback about the Chef documentation. See https://docs.chef.io/feedback.html or read [CONTRIBUTING](CONTRIBUTING).




## Submitting PRs (or "Where do I make changes?")

To determine the location of the actual content on a page:

1. Find the URL of that page on the root of docs.chef.io. For example, the template resource: https://docs.chef.io/resource_template.html
2. In the chef-docs repo on Github (https://github.com/chef/chef-web-docs), open the `chef_master` directory and find the .rst file in that directory that corresponds exactly to the file on the docs site: resource_template.rst
3. Open that file and view it in its raw text format. For example: https://raw.githubusercontent.com/chef/chef-web-docs/master/chef_master/source/resource_template.rst
4. Find the section in which the change is to be made. In nearly every case that section is included using a pattern similar to: .. include:: ../../includes_resources/includes_resource_template_attributes.rst.
5. In the chef-docs repo, follow that path to the directory, and then the specific file.
6. Open that file and make your changes.

See https://docs.chef.io/style_guide.html for any questions about the structure and formatting of the individual topics.

## Setting Up


Fork and clone the chef-docs repo to your own account://

    git clone https://github.com/chef/chef-web-docs.git
    # will take a while, repo is very large

You may wish to use [virtualenv](http://www.virtualenv.org/) & [virtualenvwrapper](http://virtualenvwrapper.readthedocs.org/) (similar to rvm or rbenv), to isolate this Python environment from others, so start out like so:

    mkvirtualenv chef-docs
    workon chef-docs
    echo chef-docs > .venv # personal preference, can hook into other control projects later

If you don't use this and want to install into your system Python, prepend this command with `sudo`:

    pip install sphinx

Will install all the dependencies you should need.


## Building Docs

There's a `Makefile` in the root of the repo, that should have the majority of the tasks you'll ever need.

Run:

    make release

This will build *all* the documentation into HTML, and place it inside `./build/chef/`.
Open `./build/chef/index.html` to view the rendered files locally.

IMPORTANT: Depending on what has changed since the last time a build was run, the build process can take anywhere from a few minutes to a few hours. The make file gets changed a lot because Chef uses this file to manage how the docs get published to our website. For your local builds, you may want to edit the make file prior to building to only use the chef_master build, which is the build to use for the current version of Chef.

The first time you run the build, it will take longer (45-75 mins), as it has to generate _every_ file from scratch. (This time estimate assumes that you're building only the chef_master docs collection; additional docs collections will take additional time.)

This will also apply when you've run the `make clean` command, which effectively resets your working environment or if files located in the `/swaps` folder are changed.

Subsequent runs of `make release` should be relatively fast (2-5 mins), and you can use subsets. For example: `master` for the main docs build, `server` for the Chef server, `client` for the chef-client, and so on. The full list is available at the top of the `makefile`.

## License

[Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/)

## Questions?

Open an [Issue](https://github.com/chef/chef-web-docs/issues) and ask. Or send email to docs@chef.io.
