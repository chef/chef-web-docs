.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how a case statement can be used to tell the |chef client| how to handle different versions of the |jdk|:

.. code-block:: ruby

   case jdk_version
   when '6'
     tarball_url = node['java']['jdk']['6'][arch]['url']
     tarball_checksum = node['java']['jdk']['6'][arch]['checksum']
   when '7'
     tarball_url = node['java']['jdk']['7'][arch]['url']
     tarball_checksum = node['java']['jdk']['7'][arch]['checksum']
   end
