.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``have_app_pool`` matcher tests if the named application pool exists for the site:

.. code-block:: ruby

   it { should have_app_pool('DefaultAppPool') }

For example, testing if a site's application pool inherits the settings of the parent application pool:

.. code-block:: ruby

   it { should have_app_pool('/') }
