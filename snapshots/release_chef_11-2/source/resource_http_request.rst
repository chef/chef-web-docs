.. THIS PAGE DOCUMENTS chef-client version 11.2

=====================================================
http_request
=====================================================

.. include:: ../../includes_resources/includes_resource_http_request.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_http_request_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_http_request_actions_11-16.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_http_request_attributes_12-5.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_http_request_providers.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Send a GET request**

.. include:: ../../step_resource/step_resource_http_request_send_get.rst

**Send a POST request**

.. include:: ../../step_resource/step_resource_http_request_send_post.rst

**Transfer a file only when the remote source changes**

.. include:: ../../step_resource/step_resource_remote_file_transfer_remote_source_changes.rst
