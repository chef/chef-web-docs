.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to return a hash of the cookbooks and cookbook versions (including all dependencies) that are required by the ``run_list`` array. Version constraints may be specified using the ``@`` symbol after the cookbook name as a delimiter. Version constraints may also be present when the ``cookbook_versions`` attributes is specified for an environment or when dependencies are specified by a cookbook.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organizations/NAME/environments/NAME/cookbook_versions

with a request body similar to:

.. code-block:: javascript

   {
     "run_list": [
       "zed@0.0.1",
       "bar",
       "mysql",
       "gem",
       "nginx@0.99.2",
       "cron",
       "foo"
     ]
   }

where ``@x.x.x`` represents a constraint for a cookbook version.

**Response**

The response will return a list of cookbooks that are required by the ``run_list`` array contained in the request. The cookbooks that are returned are often the latest versions of each cookbook. Depending on any constraints present in the request or on dependencies a cookbook may have for specific cookbook versions, a request may not always return the latest cookbook version for each cookbook.

The response is similar to:

.. code-block:: javascript

   {
     "cookbook_name": {
       "recipes": [
         {
           "name": "default.rb",
           "path": "recipes/default.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "recipe_name.rb",
           "path": "recipes/recipe_name.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           ...
         }
       ],
       "definitions": [
   
       ],
       "libraries": [
   
       ],
       "attributes": [
   
       ],
       "files": [
   
       ],
       "templates": [
         {
           "name": "template_name.erb",
           "path": "templates/default/template_name.erb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           ...
         }
       ],
       "resources": [
   
       ],
       "providers": [
   
       ],
       "root_files": [
         {
           "name": "metadata.rb",
           "path": "metadata.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         }
       ],
       "cookbook_name": "cookbook_name-1.0.2",
       "metadata": {
         "name": "cookbook_name",
         "description": "description",
         "long_description": "",
         "maintainer": "maintainer",
         "maintainer_email": "maintainer@email.com",
         "license": "license",
         "platforms": {
         },
         "dependencies": {
           "cookbook_name": ">= 0.0.0",
           "cookbook_name": ">= 1.2.3",
           ...
           "cookbook_name": ">= 0.1.0"
         },
         "recommendations": {
         },
         "suggestions": {
         },
         "conflicting": {
         },
         "providing": {
           "cookbook_name": ">= 0.0.0",
           "cookbook_name::recipe_name": ">= 0.0.0",
           "cookbook_name::recipe_name": ">= 1.2.3",
           "cookbook_name::recipe_name": ">= 0.1.0"
         },
         "replacing": {
         },
         "attributes": {
         },
         "groupings": {
         },
         "recipes": {
           "cookbook_name": "description",
           "cookbook_name::recipe_name": "",
           ...
           "cookbook_name::recipe_name": ""
         },
         "version": "0.0.0"
       },
       "version": "0.0.0",
       "name": "cookbook_name-1.0.2",
       "frozen?": false,
       "chef_type": "cookbook_version",
       "json_class": "Chef::CookbookVersion"
     },
     "cookbook_name": {
        "recipes": [
         {
           "name": "default.rb",
           "path": "recipes/default.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
       ],
       "definitions": [
   
       ],
       "libraries": [
         {
           "name": "library_file.rb",
           "path": "libraries/library_file.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         }
       ],
       "attributes": [
         {
           "name": "default.rb",
           "path": "attributes/default.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         }
       ],
       "files": [
   
       ],
       "templates": [
   
       ],
       "resources": [
   
       ],
       "providers": [
   
       ],
       "root_files": [
         {
           "name": ".gitignore",
           "path": ".gitignore",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": ".kitchen.yml",
           "path": ".kitchen.yml",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "CHANGELOG.md",
           "path": "CHANGELOG.md",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "CONTRIBUTING",
           "path": "CONTRIBUTING",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "LICENSE",
           "path": "LICENSE",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "metadata.json",
           "path": "metadata.json",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "metadata.rb",
           "path": "metadata.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "README.md",
           "path": "README.md",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
       ],
       "chef_type": "cookbook_version",
       "name": "cookbook_name-1.0.2",
       "cookbook_name": "cookbook_name",
       "version": "1.0.2",
       "metadata": {
         "name": "cookbook_name",
         "description": "description",
         "long_description": "",
         "maintainer": "maintainer",
         "maintainer_email": "maintainer@email.com",
         "license": "license",
         "platforms": {
         },
         "dependencies": {
         },
         "recommendations": {
         },
         "suggestions": {
         },
         "conflicting": {
         },
         "providing": {
         },
         "replacing": {
         },
         "attributes": {
         },
         "groupings": {
         },
         "recipes": {
         },
         "version": "1.0.2"
       },
       "frozen?": true,
       "json_class": "Chef::CookbookVersion"
     },
     "cookbook_name": {
      ...
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|
   * - ``412``
     - |response code 412 cookbook version|
   * - ``413``
     - |response code 413 entity_too_large|
