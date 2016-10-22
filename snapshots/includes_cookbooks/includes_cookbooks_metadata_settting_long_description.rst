.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example, to embed the long description within the field itself:

.. code-block:: ruby

   long_description <<-EOH
   = DESCRIPTION:

   Complete Debian/Ubuntu style Apache2 configuration.

   = REQUIREMENTS:

   Debian or Ubuntu preferred.

   Red Hat/CentOS and Fedora can be used but will be converted to
   a Debian/Ubuntu style Apache as it's far easier to manage
   with Chef.

   = ATTRIBUTES:
   
   The file attributes/apache.rb contains the following attribute
   types:
   
   * platform specific locations and settings.
   * general settings
   * pre-fork attributes
   * worker attributes

   General settings and pre-fork/worker attributes are tunable.
   EOH

Or to read the contents from a specified file:

.. code-block:: ruby

   long_description IO.read(File.join
     (File.dirname(__FILE__), 'README.rdoc')
   )
