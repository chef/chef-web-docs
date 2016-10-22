.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to use ``only_if`` with one (or more) cookbook attributes to ensure that packages are only installed when necessary. In this case, three attributes exist in the ``/attributes/default.rb`` file: ``use_openssl``, ``use_pcre``, and ``use_zlib``. Each of these attributes are defined as ``false`` by default. The ``only_if`` attributes are used to test for the presence of these packages on the target node before then asking the chef-client to complete the process of installing these packages. If the packages are already present, the chef-client will do nothing.

.. code-block:: ruby

   package 'libpcre3-dev' do
     only_if { node['haproxy']['source']['use_pcre'] }
   end
   
   package 'libssl-dev' do
     only_if { node['haproxy']['source']['use_openssl'] }
   end
   
   package 'zlib1g-dev' do
     only_if { node['haproxy']['source']['use_zlib'] }
   end
