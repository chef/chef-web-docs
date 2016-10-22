.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``DELETE`` method is used to delete a policy document for a specific policy revision.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/GROUP/policies/NAME/revisions/ID

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": []
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {},
     "override_attributes": {},
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
       }
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
