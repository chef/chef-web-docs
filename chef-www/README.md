# chef-www

This is the hugo repository to manages chef.sh.

## The `chef` theme

The `chef` theme is kept in the [chef/chef-hugo-theme](https://github.com/chef/chef-hugo-theme) repository. Layouts, styling, javascript, and other assets for the site as a whole should be kept with the theme. Assets like images that are specific to content pages should be kept in the `site/static/` folder.

## External Data Sources

The "source of truth" for documentation content (`site/content/docs/*`) for the various software products is kept in the software projects GitHub repository and synced to this repository as necessary. Any modification to documentation for a product should be made in that product's GitHub repository.

## External Products

Name | GitHub Repository | Folder Name(1) | Shortcode Prefix(2)
--- | --- | --- | ---
Chef Workstation | [chef/chef-workstation](https://github.com/chef/chef-workstation) | `chef-workstation` | `cw`
Chef Client | [chef/chef](https://github.com/chef/chef) | `chef-client` | `cc`
Chef Server | [chef/chef-server](https://github.com/chef/chef-server) | `chef-server` | `cs`
ChefDK | [chef/chef-dk](https://github.com/chef/chef-dk) | `chefdk` | `cdk`

1. The folder name to use when nesting content in `content/docs`, `data`,  and `static/images`.
2. The `layouts/shortcodes` folder only supports a single depth. To avoid collisions, we namespace each shortcode with a product prefix.

## Development

### Install Dependencies

* Hugo

### Launching live-reload Development Environment

```
make serve
```
