.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To define OAuth 2 information for Chef Supermarket, create a Hash similar to:

   .. code-block:: ruby

      oc_id['applications'] ||= {}
      oc_id['applications']['supermarket'] = {
        'redirect_uri' => 'https://supermarket.mycompany.com/auth/chef_oauth2/callback'
      }
