.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The actions view always shows the most recent actions, including a one-line summary of what happend. For example: "Client dg created node - db a day ago." Each action in the view may be expanded to show action details, including the name and request identifier of the chef-client and the name of the Chef server instances involved in the action.

Every user in Chef Analytics has a picture that is associated with the entry that is created as a result of an action they perform. For the chef-client, it's a picture of a computer screen (always). And for users, the images are fetched from gravatar.com, based on the email address associated with that user. If that user has uploaded a picture to gravatar.com, that picture will be used.

To view action details:

#. Open Chef Analytics.
#. Choose an action and expand it.

   .. image:: ../../images/step_actions_webui_view_action_details.png
