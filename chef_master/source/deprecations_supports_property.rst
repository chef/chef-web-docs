=======================================================
Deprecation: "Supports" metaproperty (CHEF-8)
=======================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_supports_property.rst>`__

The ``user`` resource previously allowed a cookbook author to set policy for the resource in two ways. The ``supports`` metaproperty, which is now deprecated, enabled the ``manage_home`` and ``non_unique`` properties to be set.



The ``supports`` metaproperty was deprecated in Chef Client 12.14 and will be removed in Chef Client 13.

Example
===========

.. code-block:: ruby

  user "betty" do
    supports({
      manage_home: true,
      non_unique: true
    })
  end

Remediation
=============

Make the ``manage_home`` and ``non_unique`` settings properties rather than parts of the ``supports`` hash.

.. code-block:: ruby

  user "betty" do
    manage_home true
    non_unique true
  end
