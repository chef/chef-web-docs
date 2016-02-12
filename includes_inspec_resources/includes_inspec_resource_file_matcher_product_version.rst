.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``product_version`` matcher tests if the file's product version matches the specified value. The difference between a file's "file version" and "product version" is that the file version is the version number of the file itself, whereas the product version is the version number associated with the application from which that file originates:

.. code-block:: ruby

   its('product_version') { should eq 2.3.4 }
