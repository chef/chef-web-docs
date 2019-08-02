=====================================================
Deprecation: JSON Auto Inflate (CHEF-1)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_json_auto_inflate.rst>`__

.. meta:: 
    :robots: noindex 
    
Internally, the ``Chef::REST`` class attempts to guess which Chef class a JSON document relates too, and then automatically turns the JSON in to that class.



This deprecation warning was added in Chef Client 12.7.2, and JSON auto inflation will be removed permanently in Chef Client 13.

Example
=====================================================

When loading an environment from the Chef Infra Server, you might previously have written:

.. code-block:: ruby

  name = "my_environment"
  chef_server_rest.get("environments/#{name}")

and received a ``Chef::Environment`` object back.

Remediation
=====================================================

You now need to explicitly create a new object of the desired type.

.. code-block:: ruby

  name = "my_environment"
  Chef::Environment.from_hash chef_server_rest.get("environments/#{name}")
