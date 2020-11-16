# Infra Resource page YAML files

The resource pages and [resource reference page](https://docs.chef.io/resources/)
are generated using YAML data located in `chef-web-docs/data`.
The YAML data is generated directly from the Chef Infra code.

Each resource page has references a YAML data file stored in
`chef-web-docs/data`. For example, the apt package resource data is stored in
`chef-web-docs/data/infra/resources/apt_package.yaml`.

The templates that generate those resource pages are found in
`chef-web-docs/themes/docs-new/layouts`. The templates that generate the tables of
contents for the resource are stored in `chef-web-docs/themes/docs-new/layouts/partials`.

There are two template types, `infra_resources.html` and `infra_resources_all.html`.
The `infra_resources.html` template is used to generate each individual resource page,
and the `infra_resources_all.html` template generates the
[resources reference page](https://docs.chef.io/resources/).

For general information about YAML see the official [YAML website](https://yaml.org/).

## Markdown Pages

Each resource YAML file must have a Markdown page that calls it. You can use the `resource.md`
archetype file to generate an individual Markdown page (`hugo new -k resource content/resources/<RESOURCE NAME.md`), or use the `make resource_files` to automatically generate new resource files for every resource in the
`data/infra/resources` directory.

Each page has the following parameters:

**title**

This is the title of the page as it appears at the top of its page or at the top of
its section in the resource reference page. For example, `apt_package resource`.

**draft**

Hugo will not render the page if set to `true`.

**aliases**

Pages that you want to redirect to the page that you are editing. See Hugo's
[aliases documentation](https://gohugo.io/content-management/urls/#aliases).

**data_path**

An array that specifies the path to the individual data file in the `data` directory.
For example, the `alternatives.yaml` file in `data/infra/resources` is specified
like this: `data_path = ["infra","resources","alternatives"]`

The `_index.md` file reads through all of the YAML files, so its data_path value is
`["infra","resources"]`

**layout**

The page layout that Hugo will use to render the page.
Use `layout = "infra_resource"` for individual resource pages. Use
`layout = "infra_resources_all"` for the `_index.md` page.

**menu/docs**

This section provides information that will add the page to the left navigation
menu. Delete this entire section if you want to remove a page from the left
navigation menu.

See the example at the bottom of this section.

- title

	The name of the page as it appears in the left navigation menu.

- identifier

	The unique identifier for the page. No two pages in the left navigation menu
	can have the same identifier. For this reason we've adopted the convention of
	creating identifiers that start with the path of the page in the left navigation
	menu followed by a space and then the name of the page itself.

- parent

	The location of the resource page in the left navigation menu. For resource pages
	this is always `chef_infra/cookbook_reference/resources`.

Example menu section:

```
menu:
  infra:
    title: resource_name
    identifier: chef_infra/cookbook_reference/resources/resource_name
      resource_name
    parent: chef_infra/cookbook_reference/resources
```

**robots**

This adds meta robots directions to a page that instruct search engines crawlers
how to crawl a page. Valid values are `noindex` and `nofollow`, separated by a comma. This is
useful for removing a page from [Swiftype](https://swiftype.com/documentation/site-search/crawler-configuration/meta-tags#robots_meta)
and Google search results. See the [robotstxt.org](https://www.robotstxt.org/meta.html)
site for more information about meta robots tags.

If this is deleted or left blank, Hugo will use the site robots parameter in the
`config.toml` file.

## YAML data

The YAML data is contained in a YAML file in `chef-web-docs/data`

The data in those files can be split into two categories:
resource data, and shortcodes.

### Resource data

**resource**

This is the name of the resource. For example, `apt_package`.

**resource_reference**

Display or hide a page. If set to `true`, the page will appear in the [resource
reference](/resources) and its own individual page will
appear in https://docs.chef.io/resources/page_name/. Values are `true` or `false`.

**resource_description_list**

This is a list of content that will build the introductory description section of each
resource page. Markdown, notes, warnings, and shortcodes can be added to the list.
Notes and warnings can include Markdown or shortcode content.

This content will display on the page in the same order that it appears in the list.

Example:

```
resource_description_list:
- markdown: 'This is markdown text. It will be added before the note below.'
- note:
    shortcode: shortcode_file_name.md
		markdown: This Markown text will appear in a note but after the shortcode above.
```

**resource_new_in**

This will add **New in Chef Infra Client X.Y** to the description of the
resource page. The text won't appear if value is blank.

Example:

```
resource_new_in: 14.0
```

**syntax_description**

A short introductory description in Markdown that explains the syntax of the resource and includes
an example code block.

For example:

    syntax_description: "The build_essential resource has the following syntax:\n\n```\
      \ ruby\nbuild_essential 'name' do\n  compile_time      true, false # default value:\
      \ false\n  action            Symbol # defaults to :install if not specified\nend\n\
      ```"

or,

    syntax_description: "A **bash** resource block executes scripts using Bash:\n\n```\
      \ ruby\nbash 'extract_module' do\n  cwd ::File.dirname(src_filepath)\n  code <<-EOH\n\
      \    mkdir -p #{extract_path}\n    tar xzf #{src_filename} -C #{extract_path}\n\
      \    mv #{extract_path}/*/* #{extract_path}/\n    EOH\n  not_if { ::File.exist?(extract_path)\
      \ }\nend\n```"


**syntax_properties_list**

The properties of the code block in `syntax_code_block` in list format.

For example:

```
syntax_properties_list:
- '`apt_preference` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`glob`, `package_name`, `pin`, and `pin_priority` are the properties available
  to this resource.'
```

**syntax_full_code_block**

A code block showing the full syntax of all of the properties available in a resource. This can be omitted and nothing will be displayed.

**syntax_full_properties_list**

A list of all of the properties in the code block in ``syntax_full_code_block``. This can be omitted and nothing will be displayed.

**syntax_shortcode**

Some resources use a shortcode to display their syntax section.

For example:

``syntax_shortcode: resource_log_syntax.md``

**actions_list**

This is a list of actions followed by Markdown or a shortcode that describes each action.

The example below will display the `install` action followed by a markdown description,
and then `nothing` action followed by a shortcode.

```
actions_list:
  :install:
    markdown: Markdown that describes the install action.
  :nothing:
    shortcode: resources_common_actions_nothing.md
```

**properties_shortcode**

The properties section of some resource pages is a shortcode. This will display
the shortcode specified in lieu of describing the properties using ``properties_list``.

**properties_list**

This is a list of each property in a resource.

- property

  The name of the property.

- ruby_type

  The ruby data type of the property.

- required

  `True` or `False`. Indicates if the property is required by the resource and
  adds ``REQUIRED`` to the description of the property.

- default_value

	The default value of the property.

- new_in

	The version of Chef Infra Client that this property was introduced in.

- description_list

	A list of content used to describe the property. Valid keys are `markdown`,
	`note`, `warning`, and `shortcode`. Notes and warnings can have markdown or
	shortcode content.

	This content will display on the page in the same order that it appears in the list.

For example:

```
properties_list:
- property: property name
  ruby_type: String
  required: false
  default_value: null
  new_in: 14.0
  description_list:
  - markdown: Some text describing the property.
	- note:
		- shortcode: shortcode_file.md
	- warning:
		- markdown: Markdown text warning the user about the propery.
```

**examples**

Each example should start with a bolded heading followed by
blocks of text that describe and demonstrate how the resource works.


    examples: |
      **Update the Apt repository at a specified interval**:

      ```ruby
      apt_update 'all platforms' do
        frequency 86400
        action :periodic
      end
      ```

      **Update the Apt repository at the start of a Chef Infra Client run**:

      ```ruby
      apt_update 'update'
      ```

### Shortcodes

These values, if set to `true`, will display sections of text that include headings
followed by text from various shortcodes.

**handler_types**

Only used in the chef handler resource. This adds the **Handler Types** section
to this resource page.

**registry_key**

Only used in the registry key resource. This adds the **Registry Key Path Separators**
and **Recipe DSL Methods** sections to resource page.

**nameless_apt_update**

Only used in the apt update resource. Adds the **Nameless** section to the
apt update resource page.

**nameless_build_essential**

Only used in the build essential resource. Adds the **Nameless** section to the
build essential resource page.

**resource_package_options**

Only used in the package resource page. Adds the **Gem Package Options** section to the resource page.

**multi_package_resource**

Used in the apt, dnf, homebrew, package, pacman, yum, and zypper package resource
pages. Adds the **Multiple Packages** section to the Common Resource Functionality and
Properties sections of the resource page.

**resource_directory_recursive_directories**

Used in the directory and remote directory resource pages. Adds the **Recursive Directories**
section to the Properties section of the resource page.

**resources_common_atomic_update**

Used in the cookbook file, file, remote file, and template resource pages. Adds
the **Atomic File Updates** section to the Properties section of the resource page.

**properties_resources_common_windows_security**

Used in the cookbook file, directory, file, remote file, and template resource
pages. Adds the **Windows File Security** section to the Properties section of the
resource page.

**remote_file_prevent_re_downloads**

Used in the remote file resource page. Adds the **Prevent Re-downloads** section
to the Properties section of the resource page.

**remote_file_unc_path**

Used in the remote file resource page. Adds the **Access a remote UNC path on Windows** section
to the Properties section of the resource page.

**ps_credential_helper**

Used in the dsc script resource page. Adds the **ps_credential Helper** section
to the Properties section of the resource page.

**ruby_style_basics_chef_log**

Used in the log resource page. Adds the **Log Entries** section
to the resource page.

**debug_recipes_chef_shell**

Used in the breakpoint resource page. Adds the **Debug Recipes with chef-shell**
section to the resource page.

**template_requirements**

Used in the template resource page. Adds the **Debug Recipes with chef-shell**
section to the Properties section of the resource page.

**resources_common_properties**

Used in several resource pages. Adds the **Common Properties** section to the
Common Resource Functionality section of the resource page.

**resources_common_notification**

Used in several resource pages. Adds the **Notifications** section to the
Common Resource Functionality section of the resource page.

**resources_common_guards**

Used in several resource pages. Adds the **Guards** section to the
Common Resource Functionality section of the resource page.

**resources_common_guard_interpreter**

Used in the script resource page. Adds the **Guard Interpreter** section to the
Common Resource Functionality section of the resource page.

**remote_directory_recursive_directories**

Used in the remote directory resource page. Adds the **Recursive Directories**
section to the Common Resource Functionality section of the resource page.

**common_resource_functionality_resources_common_windows_security**

Used in the remote directory resource page. Adds the **Windows File Security**
section to the Common Resource Functionality section of the resource page.

**handler_custom**

Used in the chef handler resource page. Adds the **Custom Handlers**
section to the resource page.

**cookbook_file_specificity**

Used in the cookbook file resource page. Adds the **File Specificity**
section to the resource page.

**unit_file_verification**

Used in the systemd_unit resource page. Adds the **Unit File Verification**
section to the resource page.

## Resource page tables of contents

The tables of contents templates for the resource pages are located in
`chef-web-docs/themes/docs-new/layouts/partials`.

The tables of contents for the resource reference page and the individual resource
pages are generated in the same way that the resource reference
page and the individual resources pages are created. Hugo crawls through the resource
YAML files and builds an unordered list listing each H1 through H3 heading. This
means that if a section of content is added or removed from the resource page
templates, then those headings also have to be added or removed to the respective
tables of contents templates.

Failure to update the resource page table of contents templates
may lead to links that don't link to the proper content, links that don't work properly,
or content that isn't linked to in the table of contents.