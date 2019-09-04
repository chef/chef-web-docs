+++
title = "Deprecation: Legacy HWRP mixins (CHEF-23)"
draft = false

aliases = "/deprecations_legacy_hwrp_mixins.html"


  
    
    
    
    
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_legacy_hwrp_mixins.rst)

<meta name="robots" content="noindex">

In Chef Client 14 several legacy mixins will be removed. Usage of these
mixins has resulted in deprecation warnings for several years. They were
traditionally used in some HWRPs, but are rarely found in code available
on the Supermarket. Foodcritic rules
[FC097](http://www.foodcritic.io/#FC097),
[FC098](http://www.foodcritic.io/#FC098),
[FC099](http://www.foodcritic.io/#FC099),
[FC100](http://www.foodcritic.io/#FC100), and
[FC102](http://www.foodcritic.io/#FC102) have been introduced to detect
these mixins:

-   `Chef::Mixin::LanguageIncludeAttribute`
-   `Chef::Mixin::RecipeDefinitionDSLCore`
-   `Chef::Mixin::LanguageIncludeRecipe`
-   `Chef::Mixin::Language`
-   `Chef::DSL::Recipe::FullDSL`
