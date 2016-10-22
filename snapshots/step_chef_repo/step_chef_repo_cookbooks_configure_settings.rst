.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To configure cookbook-specific copyright, email, and license data, add the following to the knife.rb file in the chef-repo:

.. code-block:: bash

   cookbook_copyright "Example, Com."
   cookbook_email     "cookbooks@example.com"
   cookbook_license   "apachev2"

where the ``cookbook_copyright`` and ``cookbook_email`` are specific to the organization and ``cookbook_license`` is either ``apachev2`` or ``none``. These settings will be used in the default recipe and in corresponding values in the metadata.rb file, but can be modified in those locations as well (if they should be different from the default values contained in the knife.rb file.)
