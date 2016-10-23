.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example will set ``package_name`` to ``httpd`` for the Red Hat platform and to ``apache2`` for the Debian platform:

.. code-block:: ruby

   package_name = value_for_platform(
     ['centos', 'redhat', 'suse', 'fedora' ] => {
       'default' => 'httpd'
     },
     ['ubuntu', 'debian'] => {
       'default' => 'apache2'
     }
   )

The following example will set ``package`` to ``apache-couchdb`` for OpenBSD platforms, ``dev-db/couchdb`` for Gentoo platforms, and ``couchdb`` for all other platforms:

.. code-block:: ruby

   package = value_for_platform(
     'openbsd' => { 'default' => 'apache-couchdb' },
     'gentoo' => { 'default' => 'dev-db/couchdb' },
     'default' => 'couchdb'
   )

The following example shows using version constraints to specify a value based on the version:

.. code-block:: ruby

   value_for_platform(
     'os1' => { '< 1.0' => 'less than 1.0',
                '~> 2.0' => 'version 2.x',
                '>= 3.0' => 'version 3.0',
                '3.0.1' => '3.0.1 will always use this value' }
   )
