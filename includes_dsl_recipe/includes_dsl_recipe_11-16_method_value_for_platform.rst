.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``value_for_platform`` method in a recipe to select a value based on the ``node['platform']`` and ``node['platform_version']`` attributes. These values are detected by |ohai| during every |chef client| run.

The syntax for the ``value_for_platform`` method is as follows:

.. code-block:: ruby

   value_for_platform( ['platform', ...] => { 'version' => value } )

where:

* ``'platform', ...`` is a comma-separated list of platforms, such as |redhat|, |suse|, or |fedora|
* ``version`` specifies the version of that platform
* ``value`` specifies the value that will be used if the node's platform matches the ``value_for_platform`` method

When each value only has a single platform, use the following syntax:

.. code-block:: ruby

   value_for_platform(
     'platform' => { 'version' => 'value' },
     'platform' => { 'version' => 'value' },
     'platform' => 'value'
   )

When each value has more than one platform, the syntax changes to:

.. code-block:: ruby

   value_for_platform(
     ['platform', 'platform', ... ] => {
      'version' => 'value'
     },
   )

The following example will set ``package_name`` to ``httpd`` for the |redhat| platform and to ``apache2`` for the |debian| platform:

.. code-block:: ruby

   package_name = value_for_platform(
     ['centos', 'redhat', 'suse', 'fedora' ] => {
      'default' => 'httpd'
     },
     ['ubuntu', 'debian'] => {
      'default' => 'apache2'
     }
   )

The following example will set ``package`` to ``apache-couchdb`` for |open bsd| platforms, ``dev-db/couchdb`` for |gentoo| platforms, and ``couchdb`` for all other platforms:

.. code-block:: ruby

   package = value_for_platform(
     'openbsd' => { 'default' => 'apache-couchdb' },
     'gentoo' => { 'default' => 'dev-db/couchdb' },
     'default' => 'couchdb'
   )
