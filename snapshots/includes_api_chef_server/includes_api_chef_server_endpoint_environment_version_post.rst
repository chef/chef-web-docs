.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to return a hash of the cookbooks and cookbook versions (including all dependencies) that are required by the ``run_list`` array. Version constraints may be specified using the ``@`` symbol after the cookbook name as a delimiter. Version constraints may also be present when the ``cookbook_versions`` attributes is specified for an environment or when dependencies are specified by a cookbook.

This method has no parameters.

**Request**

.. code-block:: none

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
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``412``
     - Not allowed. A set of cookbooks and/or cookbook versions could not be found that met all of the requirements of the run-list. A cookbook in the run-list may not exist. A dependency may be present for a cookbook that does not exist. A constraint on a cookbook made by a run-list, environment, or cookbook version, may not match an available cookbook version.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.
