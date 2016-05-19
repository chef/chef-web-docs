.. THIS PAGE IS LOCATED AT THE /release/analytics/ PATH.

=====================================================
|api analytics|
=====================================================

.. include:: ../../includes_api_analytics/includes_api_analytics.rst

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Encryption
=====================================================
All connections to |chef analytics| from any web browser, any API client, and any service uses HTTPS. HTTP access to the |chef analytics| platform is not allowed.
 
Authentication
=====================================================
|chef analytics| uses token-based authentication to the |api analytics|.

User Access
-----------------------------------------------------
Users authenticate to the |api analytics| using an |oauth| 2.0 token. |chef analytics| uses the |service ocid| service that is built into the |chef server| as the identity source. When a user access |chef analytics| from a web browser, the web browser completes the |oauth| negotiation with the |service ocid| service to ensure that the token is valid.

Service Access
-----------------------------------------------------
Services authenticate to the |api analytics| as a privileged user using a keyed-hash message authentication code (HMAC) and is based on a similar mechanism used by |amazon aws| services.

A request is authenticated by concatenating elements of the request to form a string. Then a private key calculates the request signature using the HMAC, which is then added to the request as a header.

After a request is authenticated, it will fetch its copy of the private key, and then uses it to compute a signature, which is then compared against the signature in the header. If these signatures match, the service is authorized. If these signatures do not match, the system responds with an error message.

Endpoints
=====================================================
The following endpoints may be accessed globally.

/actions/ID
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_action_id.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_action_id_get.rst

/actions/ID/payload
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_payload.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_payload_get.rst

/audits/ID
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_audit_id.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_audit_id_get.rst

/authentication-configuration
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_authentication_configuration.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_authentication_configuration_get.rst

.. internal API used by webhooks
.. 
.. /messages
.. -----------------------------------------------------
.. .. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_messages.rst
.. 
.. POST
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_messages_post.rst
.. 

/organization/NAME
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_organization.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_organization_get.rst

/searches
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_searches.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_searches_get.rst

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_searches_post.rst

/searches/ID
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_search_id.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_search_id_delete.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_search_id_get.rst

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_search_id_post.rst

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_search_id_put.rst

/user
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_user.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_user_get.rst

Organization Endpoints
=====================================================
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoints.rst

/actions
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_actions.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_actions_get.rst

/actions/export
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_actions_export.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_actions_export_get.rst

/aliases
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_aliases.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_aliases_get.rst

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_aliases_post.rst

/aliases/ID
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_alias_id.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_alias_id_delete.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_alias_id_get.rst

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_alias_id_put.rst

/audits
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_audits.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_audits_get.rst

/autocomplete
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_autocomplete.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_autocomplete_get.rst

/rules
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_rules.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_rules_get.rst

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_rules_post.rst

/rules/ID
-----------------------------------------------------
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_rule_id.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_rule_id_delete.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_rule_id_get.rst

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_analytics/includes_api_analytics_endpoint_rule_id_put.rst
