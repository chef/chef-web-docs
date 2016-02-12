.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get the details for a user.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /users/USERNAME

**Response**

The response will return details for a user, including their name, |chef| username, associated account details, and a list of cookbooks that are associated with the user. Cookbooks are grouped into three categories: those that are owned by this user, those in which this user has collaborated, and those that are followed.

.. code-block:: javascript

   {
     "username": "stevedanno",
     "name": "Steve Danno",
     "company": "Chef Software, Inc",
     "github": [
       "stevedanno"
     ],
     "twitter": "stevedanno",
     "irc": "stevedanno",
     "jira": "stevedanno",
     "cookbooks": {
       "owns": {
         "bacon": "https://supermarket.chef.io/api/v1/cookbooks/bacon"
         "chef-sugar": "https://supermarket.chef.io/api/v1/cookbooks/chef-sugar"
       },
       "collaborates": {
         "build-essential": "https://supermarket.chef.io/api/v1/cookbooks/build-essential"
         "jenkins": "https://supermarket.chef.io/api/v1/cookbooks/jenkin"
       },
       "follows": {
         "bacon": "https://supermarket.chef.io/api/v1/cookbooks/bacon"
         "chef-sugar": "https://supermarket.chef.io/api/v1/cookbooks/chef-sugar"
       }
     }
   }
