=====================================================
Deprecation: epic_fail (CHEF-24)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_epic_fail.rst>`__

.. meta:: 
    :robots: noindex 
    
The original name for the ``ignore_failure`` property in resources was ``epic_fail``. Our documentation hasn't referred to ``epic_fail`` for years and out of the 3500 cookbooks on the Supermarket only one uses ``epic_fail``. In Chef Client 14 we will remove the ``epic_fail`` property entirely. Foodcritic rule `FC107 <http://www.foodcritic.io/#FC107>`__ has been introduced to detect usage of ``epic_fail``.
