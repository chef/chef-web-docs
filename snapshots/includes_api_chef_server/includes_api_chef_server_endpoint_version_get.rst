.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a description of a cookbook, including its metadata and links to component files.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/cookbooks/NAME/VERSION

where ``VERSION`` can be ``_latest`` in order to float to head.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "cookbook_name": "getting-started",
     "files": [
   
     ],
     "chef_type": "cookbook_version",
     "definitions": [
   
     ],
     "libraries": [
   
     ],
     "attributes": [
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "attributes/default.rb",
         "specificity": "default",
         "name": "default.rb",
         "checksum": "fa0fc4abf3f6787fdsaasadfrc5c35de667c"
       }
     ],
     "recipes": [
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "recipes/default.rb",
         "specificity": "default",
         "name": "default.rb",
         "checksum": "7e79b1ace7728fdsadfsdaf857e60fc69"
       }
     ],
     "providers": [
   
     ],
     "resources": [
   
     ],
     "templates": [
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "templates/default/chef-getting-started.txt.erb",
         "specificity": "default",
         "name": "chef-getting-started.txt.erb",
         "checksum": "a29d6f2545sdffds1f140c3a78b1fe"
       }
     ],
     "root_files": [
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": ".DS_Store",
         "specificity": "default",
         "name": ".DS_Store",
         "checksum": "c107b500aafd12asdffdsdf5c2a7d6"
       },
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "metadata.json",
         "specificity": "default",
         "name": "metadata.json",
         "checksum": "20f09570e54dasdf0f3ae01e6401c90f"
       },
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "metadata.rb",
         "specificity": "default",
         "name": "metadata.rb",
         "checksum": "71027aefasd487fdsa4cb6994b66ed"
       },
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "README.rdoc",
         "specificity": "default",
         "name": "README.rdoc",
         "checksum": "8b9275e56fee974easdfasdfbb729"
       }
     ],
     "name": "getting-started-0.4.0",
     "frozen?": false,
     "version": "0.4.0",
     "json_class": "Chef::CookbookVersion",
     "metadata": {
       "maintainer": "Maintainer",
       "attributes": { },
       "suggestions": { },
       "recipes": { "getting-started": "" },
       "dependencies": { },
       "platforms": { },
       "groupings": { },
       "recommendations": { },
       "name": "getting-started",
       "description": "description",
       "version": "0.4.0",
       "maintainer_email": "sysadmin@opscode.com",
       "long_description": "= DESCRIPTION:\n\nThis cookbook is used to do some things.\n\n",
       "providing": { "getting-started": ">= 0.0.0" },
       "replacing": { },
       "conflicting": { },
       "license": "Apache 2.0"
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
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
