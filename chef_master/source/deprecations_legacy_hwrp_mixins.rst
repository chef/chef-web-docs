=====================================================
Deprecation: Legacy HWRP mixins (CHEF-23)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_legacy_hwrp_mixins.rst>`__

.. meta:: 
    :robots: noindex 
    
In Chef Client 14 several legacy mixins will be removed. Usage of these mixins has resulted in deprecation warnings for several years. They were traditionally used in some HWRPs, but are rarely found in code available on the Supermarket. Foodcritic rules `FC097 <http://www.foodcritic.io/#FC097>`__, `FC098 <http://www.foodcritic.io/#FC098>`__, `FC099 <http://www.foodcritic.io/#FC099>`__, `FC100 <http://www.foodcritic.io/#FC100>`__, and `FC102 <http://www.foodcritic.io/#FC102>`__ have been introduced to detect these mixins:

* ``Chef::Mixin::LanguageIncludeAttribute``
* ``Chef::Mixin::RecipeDefinitionDSLCore``
* ``Chef::Mixin::LanguageIncludeRecipe``
* ``Chef::Mixin::Language``
* ``Chef::DSL::Recipe::FullDSL``
