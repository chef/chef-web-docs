+++
title = "Deprecation: Legacy HWRP mixins (CHEF-23)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"
sitemapExclude = true
aliases = "/deprecations_legacy_hwrp_mixins.html"
+++

In Chef Client 14 several legacy mixins will be removed. Usage of these
mixins has resulted in deprecation warnings for several years. They were
traditionally used in some HWRPs, but are rarely found in code available
on the Supermarket.

The [Cookstyle](/workstation/cookstyle/) cop
[ChefDeprecations/UsesDeprecatedMixins](https://github.com/chef/cookstyle/blob/main/docs/cops_chefdeprecations.md#chefdeprecationsusesdeprecatedmixins)
has been introduced to detect these mixins:

- `Chef::Mixin::LanguageIncludeAttribute`
- `Chef::Mixin::RecipeDefinitionDSLCore`
- `Chef::Mixin::LanguageIncludeRecipe`
- `Chef::Mixin::Language`
- `Chef::DSL::Recipe::FullDSL`
