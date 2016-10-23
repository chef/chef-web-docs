.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to create or update a cookbook version.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/cookbooks/NAME/VERSION

with a request body similar to:

.. code-block:: javascript

   {
     "definitions": [
       {
         "name": "unicorn_config.rb",
         "checksum": "c92b659171552e896074caa58dada0c2",
         "path": "definitions/unicorn_config.rb",
         "specificity": "default"
       }
     ],
     "name": "unicorn-0.1.2",
     "attributes": [],
     "files": [],
     "json_class": "Chef::CookbookVersion",
     "providers": [],
     "metadata": {
       "dependencies": {"ruby": [], "rubygems": []},
       "name": "unicorn",
       "maintainer_email": "ops@opscode.com",
       "attributes": {},
       "license": "Apache 2.0",
       "suggestions": {},
       "platforms": {},
       "maintainer": "Opscode, Inc",
       "long_description": "= LICENSE AND AUTHOR:\n\nAuthor:: Adam Jacob...",
       "recommendations": {},
       "version": "0.1.2",
       "conflicting": {},
       "recipes": {"unicorn": "Installs unicorn rubygem"},
       "groupings": {},
       "replacing": {},
       "description": "Installs/Configures unicorn",
       "providing": {}
     },
     "libraries": [],
     "templates": [
       {
         "name": "unicorn.rb.erb",
         "checksum": "36a1cc1b225708db96d48026c3f624b2",
         "path": "templates/default/unicorn.rb.erb",
         "specificity": "default"
       }
     ],
     "resources": [],
     "cookbook_name": "unicorn",
     "version": "0.1.2",
     "recipes": [
       {
         "name": "default.rb",
         "checksum": "ba0dadcbca26710a521e0e3160cc5e20",
         "path": "recipes/default.rb",
         "specificity": "default"
       }
     ],
     "root_files": [
       {
         "name": "README.rdoc",
         "checksum": "d18c630c8a68ffa4852d13214d0525a6",
         "path": "README.rdoc",
         "specificity": "default"
       },
       {
         "name": "metadata.rb",
         "checksum": "967087a09f48f234028d3aa27a094882",
         "path": "metadata.rb",
         "specificity": "default"
       },
       {
         "name": "metadata.json",
         "checksum": "45b27c78955f6a738d2d42d88056c57c",
         "path": "metadata.json",
         "specificity": "default"
       }
     ],
     "chef_type": "cookbook_version"
   }

where the ``checksum`` values must have already been uploaded to the Chef server using the sandbox endpoint. Once a file with a particular checksum has been uploaded by the user, redundant uploads are not necessary. Unused ``checksum`` values will be garbage collected.

**Response**

This method has no response body.

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
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.
