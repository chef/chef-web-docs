.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file documents specifc behavior related to the -j option in the chef-client, chef-solo, and chef-shell executables.

Use this option to use policy files by specifying a |json| file that contains the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``policy_group``
     - |name policy_name|
   * - ``policy_name``
     - |name policy_group|

For example:

.. code-block:: javascript

   {
     "policy_name": "appserver",
     "policy_group": "staging"
   }
