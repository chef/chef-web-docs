.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The basic structure of a |kitchen yml| file is as follows:

.. code-block:: yaml

   driver: 
     name: driver_name
      
   provisioner:
     name: provisioner_name
   
   platforms:
     - name: platform-version
       driver:
         name: driver_name
     - name: platform-version
   
   suites:
     - name: suite_name
       run_list:
         - recipe[cookbook_name::recipe_name]
       attributes: { foo: "bar" }
       excludes:
         - platform-version
     - name: suite_name
       driver:
         name: driver_name
       run_list:
         - recipe[cookbook_name::recipe_name]
       attributes: { foo: "bar" }
       includes:
         - platform-version

where:

* ``driver_name`` is the name of a driver that will be used to create platform instances used during cookbook testing. This is the default driver used for all platforms and suites **unless** a platform or suite specifies a ``driver`` to override the default driver for that platform or suite; a driver specified for a suite will override a driver set for a platform
* ``provisioner_name`` specifies how the |chef client| will be simulated during testing. ``chef_zero``  and ``chef_solo`` are the most common provisioners used for testing cookbooks
* ``platform-version`` is a the name of a platform on which |kitchen| will perform cookbook testing, for example, ``ubuntu-12.04`` or ``centos-6.4``; depending on the platform, additional driver details---for example, instance names and URLs used with cloud platforms like |openstack| or |amazon ec2|---may be required
* ``platforms`` may define |chef server| attributes that are common to the collection of test suites
* ``suites`` is a collection of test suites, with each ``suite_name`` grouping defining an aspect of a cookbook to be tested. Each ``suite_name`` must specify a run-list, for example: 
   
  .. code-block:: ruby

     run_list:
       - recipe[cookbook_name::default]
       - recipe[cookbook_name::recipe_name]

* Each ``suite_name`` grouping may specify ``attributes`` as a |ruby hash|: ``{ foo: "bar" }``
* A ``suite_name`` grouping may use ``excludes`` and ``includes`` to exclude/include one (or more) platforms. For example:

  .. code-block:: ruby

     excludes:
        - platform-version
        - platform-version       # for additional platforms

For example, a very simple |kitchen yml| file:

.. code-block:: yaml

   driver: 
     name: vagrant
   
   provisioner: 
     name: chef_zero
   
   platforms:
     - name: ubuntu-12.04
     - name: centos-6.4
     - name: debian-7.1.0

  suites:
    - name: default
      run_list:
        - recipe[apache::httpd]
      excludes:
        - debian-7.1.0

This file uses |vagrant| as the driver, which requires no additional configuration because it's the default driver used by |kitchen|, |chef zero| as the provisioner, and a single (default) test suite that runs on |ubuntu| 12.04, and |centos| 6.4.

