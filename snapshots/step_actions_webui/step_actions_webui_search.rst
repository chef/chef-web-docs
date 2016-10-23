.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Actions can be searched by name. Use filters for entity name, entity type, action type, remote request identifier, and tag. Most filter fields auto-complete from a list of possible values. Use wildcard searches and data ranges to fine-tune search results.

To search actions:

#. Open Chef Analytics.
#. Choose a filter. (Most filter fields will auto-complete with a list of possible values.)

   Use ``Action Type`` to filter for the type of action, such as create, update, or delete.

   Use ``Entity Name`` to filter by Chef server object name, such as cookbook, data bag, or role.

   Use ``Entity Type`` to filter by Chef server object type, such as client, cookbook version, or role.

   Use ``Remote Request ID`` to filter by chef-client run identifier that is reported back to Chef Analytics by Reporting. This filter is useful for correlating actions that have occurred during specific chef-client runs.

   Use ``Tags`` to filter by user-defined tags. Each user agent that performs an action---knife, Berkshelf, chef-client, Chef management console---is assigned a tag.

   .. image:: ../../images/step_actions_webui_search_filters.png

#. Choose a date range. There are three options: after the specified date, before the specified date, or within a specified date range.
