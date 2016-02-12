.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |kitchen yml| file may define |chef client|-specific settings, such as whether to require the |omnibus installer| or the URL from which the |chef client| is downloaded, or to override settings in the |client rb| file:

.. code-block:: yaml
      
   provisioner:
     name: chef_zero *or* chef_solo
     require_chef_omnibus: true
     chef_omnibus_url: https://www.chef.io/chef/install.sh
   
   ...
   
   suites:
     - name: config
     run_list:
     ...
     attributes:
       chef_client:
         load_gems:
           chef-handler-updated-resources:
             require_name: "chef/handler/updated_resources"
         config:
           log_level: ":debug"
           ssl_verify_mode: ":verify_peer"
           start_handlers: [{class: "SimpleReport::UpdatedResources", arguments: []}]
           report_handlers: [{class: "SimpleReport::UpdatedResources", arguments: []}]
           exception_handlers: [{class: "SimpleReport::UpdatedResources", arguments: []}]
       ohai:
         disabled_plugins: ["passwd"]

where:

* ``require_chef_omnibus`` is used to ensure that the |omnibus installer| will be used to install the |chef client| to all platform instances; ``require_chef_omnibus`` may also be set to ``latest``, which means the newest version of the |chef client| for that platform will be used for cookbook testing
* ``chef_omnibus_url`` is used to specify the URL from which the |chef client| is downloaded
* All of the ``attributes`` for the ``config`` test suite contain specific |client rb| settings for use with this test suite

