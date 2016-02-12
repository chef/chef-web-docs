=====================================================
Authentication
=====================================================

.. include:: ../../includes_chef_auth/includes_chef_auth_authentication.rst

|chef validator|
=====================================================
.. include:: ../../includes_security/includes_security_chef_validator.rst

During a |chef client_title| Run
=====================================================
.. include:: ../../includes_security/includes_security_key_pairs_chef_client.rst

|knife_title|
=====================================================
.. include:: ../../includes_security/includes_security_key_pairs_knife.rst

|knife| can also use the |subcommand knife exec| subcommand to make specific, authenticated requests to the |chef server|. |knife| plugins can also make authenticated requests to the |chef server| by leveraging the |subcommand knife exec| subcommand.

API Requests
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife.rst

.. include:: ../../includes_plugin_knife/includes_plugin_knife_using_authenticated_requests.rst

From the Web Interface
=====================================================
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_webui.rst

Other Options
=====================================================
The most common ways to interact with the |chef server| using the |api chef server| abstract the API from the user. That said, the |api chef server| can be interacted with directly. The following sections describe a few of the ways that are available for doing that.

|curl|
-----------------------------------------------------
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_other_curl.rst

|pychef|
-----------------------------------------------------
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_other_pychef.rst

|ruby|
-----------------------------------------------------
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_other_ruby.rst

Debug Authentication Issues
=====================================================
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_debug.rst

