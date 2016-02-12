.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Create an encrypted data bag item that lives inside the ``delivery-secrets`` data bag. Give the encrypted data bag item the name:

.. code-block:: javascript

   <ENT>-<ORG>-<PROJECT>

If the project is in the ``chef`` enterprise and is in the ``CIA`` organization with a name of ``chef-web-www``, the encrypted data bag item would have the following name:

.. code-block:: javascript

   chef-CIA-chef-web-www

This should use the same encrypted data bag item that is distributed with the build nodes.
