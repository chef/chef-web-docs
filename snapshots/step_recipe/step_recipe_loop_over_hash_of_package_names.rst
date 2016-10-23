.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A hash is a collection of key-value pairs. Indexing for a hash is done using arbitrary keys of any object (as opposed to the indexing done by an array). The syntax for a hash is: ``key => "value"``.

To loop over a hash of gem package names:

.. code-block:: ruby

   {"fog" => "0.6.0", "highline" => "1.6.0"}.each do |g,v|
     gem_package g do
       version v
     end
   end
