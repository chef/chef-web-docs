.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |json| format for environments maps directly to the domain-specific |ruby| format: the same settings, attributes, and values, and a similar structure and organization, just formatted as |json|. When an environment is defined as |json| the file that contains that data must be defined as a file that ends with ``.json``. For example:

.. code-block:: javascript

   {
     "name": "dev",
     "default_attributes": {
       "apache2": {
         "listen_ports": [
           "80",
           "443"
         ]
       }
     },
     "json_class": "Chef::Environment",
     "description": "",
      "cookbook_versions": {
       "couchdb": "= 11.0.0"
     },
     "chef_type": "environment"
     }

The |json| format has two additional settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``chef_type``
     - |json dsl environment chef type|
   * - ``json_class``
     - |json dsl environment json class|
