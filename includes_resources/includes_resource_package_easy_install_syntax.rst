.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |resource package_easy_install| resource block manages a package on a node, typically by installing it. The simplest use of the |resource package_easy_install| resource is:

.. code-block:: ruby

   easy_install_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the |resource package_easy_install| resource is:

.. code-block:: ruby

   easy_install_package 'name' do
     easy_install_binary        String
     module_name                String
     notifies                   # see description
     options                    String
     package_name               String, Array # defaults to 'name' if not specified
     provider                   Chef::Provider::Package::EasyInstall
     python_binary              String
     source                     String
     subscribes                 # see description
     timeout                    String, Integer
     version                    String, Array
     action                     Symbol # defaults to :install if not specified
   end

where 

* ``easy_install_package`` tells the |chef client| to manage a package
* ``'name'`` is the name of the package
* ``:action`` identifies which steps the |chef client| will take to bring the node into the desired state
* ``easy_install_binary``, ``module_name``, ``options``, ``package_name``, ``provider``, ``python_binary``, ``source``, ``timeout``, and ``version`` are properties of this resource, with the |ruby| type shown. |see attributes|
