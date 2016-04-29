.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A wrapper cookbook is used to define project- and/or organization-specific requirements around a community cookbook.

.. image:: ../../images/supermarket_wrapper_cookbook.svg
   :width: 400px
   :align: left

In the case of installing a private |supermarket|, |company_name| recommends the use of a wrapper cookbook to specify certain attributes that are unique to your organization, while enabling the use of the generic installer cookbook which, in turn, installs the |supermarket| package behind your firewall.

All of the keys under ``node['supermarket_omnibus']`` are written out as ``/etc/supermarket/supermarket.json``. Add other keys as needed to override the default attributes specified in the |supermarket| `omnibus package <https://github.com/chef/omnibus-supermarket/blob/master/cookbooks/omnibus-supermarket/attributes/default.rb>`__. For example:

.. code-block:: ruby

   default['supermarket_omnibus']['chef_server_url'] = 'https://chefserver.mycompany.com'
   default['supermarket_omnibus']['chef_oauth2_app_id'] = '14dfcf186221781cff51eedd5ac1616'
   default['supermarket_omnibus']['chef_oauth2_secret'] = 'a49402219627cfa6318d58b13e90aca'
   default['supermarket_omnibus']['chef_oauth2_verify_ssl'] = false
