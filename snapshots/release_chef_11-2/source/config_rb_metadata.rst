.. THIS PAGE DOCUMENTS chef-client version 11.2

=====================================================
metadata.rb
=====================================================

.. include:: ../../includes_cookbooks/includes_cookbooks_metadata.rst

.. include:: ../../includes_config/includes_config_rb_metadata.rst

.. note:: .. include:: ../../includes_notes/includes_notes_metadata_json.rst

Settings
==========================================================================
This configuration file has the following settings:

``attribute``
   The list of attributes that are required to configure a cookbook. An attribute name is required, followed by any of these options: ``display_name`` (the name that appears in the user interface), ``description`` (a short description), ``choice`` (an array of choices that are presented to a user), ``calculated`` (the default value is calculated by the recipe), ``type`` (the type of value, either ``string``, ``array``, or ``hash``), ``required`` (the level of user input, either ``required``, ``recommended``, or ``optional``), ``recipes`` (an array of recipes), or ``default`` (the attribute's default value).

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_attribute.rst

``depends``
   Show that a cookbook has a dependency on another cookbook. Use a version constraint to define dependencies for cookbook versions: ``<`` (less than), ``<=`` (less than or equal to), ``=`` (equal to), ``>=`` (greater than or equal to; also known as "optimistically greater than", or "optimistic"), ``~>`` (approximately greater than; also known as "pessimistically greater than", or "pessimistic"), or ``>`` (greater than). This field requires that a cookbook with a matching name and version exists on the Chef server. When the match exists, the Chef server includes the dependency as part of the set of cookbooks that are sent to the node when the chef-client runs. It is very important that the ``depends`` field contain accurate data. If a dependency statement is inaccurate, the chef-client may not be able to complete the configuration of the system.

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_depends.rst

``description``
   A short description of a cookbook and its functionality.

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_description.rst

``license``
   The type of license under which a cookbook is distributed: ``Apache v2.0``, ``GPL v2``, ``GPL v3``, ``MIT``, or ``license 'Proprietary - All Rights Reserved`` (default). Please be aware of the licenses for files inside of a cookbook and be sure to follow any restrictions they describe.

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_license.rst

``long_description``
   A longer description that ideally contains full instructions on the proper use of a cookbook, including definitions, libraries, dependencies, and so on. There are two ways to use this field: with the contents embedded in the field itself or with the contents pulled from a file at a specified path, such as a README.rdoc located at the top of a cookbook directory. 

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_long_description.rst

``maintainer``
   The name of the person responsible for maintaining a cookbook, either an individual or an organization.

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_maintainer.rst

``maintainer_email``
   The email address for the person responsible for maintaining a cookbook. Only one email can be listed here, so if this needs to be forwarded to multiple people consider using an email address that is already setup for mail forwarding.

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_maintainer_email.rst

``name``
   Required. The name of the cookbook.

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_name.rst

``provides``
   Add a recipe, definition, or resource that is provided by this cookbook, should the auto-populated list be insufficient.

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_provides.rst

``recipe``
   A description for a recipe, mostly for cosmetic value within the Chef server user interface.

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_recipe.rst

``supports``
   Show that a cookbook has a supported platform. Use a version constraint to define dependencies for platform versions: ``<`` (less than), ``<=`` (less than or equal to), ``=`` (equal to), ``>=`` (greater than or equal to), ``~>`` (approximately greater than), or ``>`` (greater than). To specify more than one platform, use more than one ``supports`` field, once for each platform.

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_supports.rst

``version``
   The current version of a cookbook. Version numbers always follow a simple three-number version sequence.

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_version.rst
