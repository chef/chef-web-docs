.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To update the Apt repository on Debian platforms:

.. code-block:: ruby

   apt_update if node['platform_family'] == 'debian'
