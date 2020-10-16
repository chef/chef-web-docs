# Configuring Hugo

## Versioning Documentation

We can provide versioned documentation for the following Chef products:

- Chef Desktop
- Chef Infra Client
- Chef Infra Server
- Chef InSpec
- Chef Habitat
- Chef Workstation

This site requires several subdirectories, files, and parameters to build and display
documentation for several versions of a product.

### Parameters

In the site `config.toml` file, set the `params.product_version` setting to the
product and versions that Hugo should build. Each `versions` parameter
is a list with the major and minor version numbers separated by an underscore.
For example:

```
[params.product_version]
[params.product_version.chef-server]
versions = ["14_0", "13_2"]
[params.product_version.chef]
versions = ["16_6", "16_5", "16_4"]
```

Note that Hugo will only build documentation for the versions listed in this parameter
even if other versions are included in the content.

### File Organization

Hugo requires several files and subdirectories to provide
documentation for multiple versions of a product. They are:

- A product subdirectory within `content`.
- Markdown pages within that product subdirectory.
- Versioned subdirectories within that product subdirectory.
- `index.md` files within the versioned subdirectories.
- Markdown pages within the versioned subdirectories that have the same file names
  as the Markdown pages in the product subdirectory.
- A `reusable_text` subdirectory within each versioned subdirectory.
- Reusable text files that could be used across multiple pages of a version of the
  documentation.

Below is an example of what that file structure should look like.

```
content
  |- <PRODUCT>
    |- <page_name>.md
    |- <other_page_name>.md
    |- ...
    |- v<X1>_<Y1>
      |- index.md
      |- <page_name>.md
      |- <other_page_name>.md
      |- ....
      |- reusable_text
        |- <reusable_text_file1>.md
        |- <reusable_text_file2>.md
        |- ...
    |- v<X2>_<Y2>
      |- index.md
      |- <page_name>.md
      |- <other_page_name>.md
      |- ....
      |- reusable_text
        |- <reusable_text_file1>.md
        |- <reusable_text_file2>.md
        |- ...
  |- <OTHER_PRODUCT>
    |-....
```

#### Product Directory

All documentation that will be versioned must be contained within a product subdirectory
within the `content` directory. Most of these directories already exist. Valid directory
names are:

- `client`
- `server`
- `workstation`
- `inspec`
- `habitat`
- `desktop`

#### Markdown Pages

Each page that is versioned must have the `version_docs_product` parameter set to
a relevant product. For example:

`version_docs_product = "chef-server"`

The possible values for this parameter are:

- `chef`
- `chef-server`
- `chef-workstation`
- `desktop-config`
- `inspec`
- `habitat`

All other page configuration metadata (menu configuration, aliases, page title, draft)
should be included in the frontmatter as it normally exists in other pages. The
rest of the page should be blank.

**Note**

Pages within a product directory don't have to be versioned. For example,
a product introduction would contain content that's relevant to all versions of a product.
Hugo will render the content in a page without the `version_docs_product` parameter
like any other un-versioned page.

#### Version Subdirectories

All of the content that Hugo uses to build the versioned pages is stored within versioned
subdirectories. They are named after the major and minor version
numbers of a product in this format: `v<MAJOR>_<MINOR>`. For example, `v12_2` or `v16_0`.

#### `index.md`

Each versioned subdirectory must have an `index.md` file, but not an `_index.md` file.
Add `headless = true` to the frontmatter of the index page. The rest of the index page
should be blank.

See Hugo's documentation on [page bundles](https://gohugo.io/content-management/page-bundles/)
for the difference between an `_index.md` file and an `index.md` file.

Adding `headless = true` makes the directory a headless bundle. See Hugo's documentation
for more information about [headless bundles](https://gohugo.io/content-management/page-bundles/#headless-bundle).

#### Versioned Pages

Each page with the `version_docs_product` parameter set in its frontmatter must have
matching pages with the exact same file name in each of the version subdirectories.

These versioned pages contain the text that will be added to the parent page.

The pages don't require any frontmatter, although adding `title` and `version` parameters
can be helpful if you are editing multiple pages at the same time.

#### Reusable Text

We often need blocks of text that are identical from one page to the next. Add
these reusable text files to the `reusable_text` directory within each version
directory.

To add a reusable text file to a page, use the `reusable_text_versioned` shortcode by adding
`{{< reusable_text_versioned file="<FILENAME>" >}}` to the text of the versioned Markdown page.
Ommit the `.md` suffix from the filename in the `file` parameter.

### Behind the Scenes

When Hugo finds a page with the `version_docs_product` parameter, it takes the
value of that parameter and looks for the matching value in the `params.product_version`
parameter in the site's `config.toml` file. It grabs the version numbers for that product
and looks for subdirectories with matching version numbers. From the versioned
subdirectories, it grabs the content from the file with the same name as the original file.

Hugo renders the content from those versioned files inside `<div>` sections and adds
a `class` attribute with the product and version number.

Hugo also renders a table of contents for each versioned file, also within `<div>`
sections with a `class` attribute of the product and version number.

Hugo automatically generates heading `id` attributes for each heading on a page.
On a normal page, if Hugo is presented with several headings that have the same
text, it will add a suffix to the end of each subsequent heading `id`. However,
this does not work if Hugo generates one page using contents from multiple pages.
This means that headings with the same text will have headings with the same `id`
value.

To fix this, the partials that process this content automatically add a version
number suffix to each heading `id` attribute. The heading links in the table of
contents are also modified so they'll properly link to the correct headings.
