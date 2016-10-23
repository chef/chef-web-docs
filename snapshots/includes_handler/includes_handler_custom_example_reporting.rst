.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Start handler functionality was added when Chef started building add-ons for the Chef server. The Reporting add-on is designed to create reporting data based on a chef-client run. And since Reporting needs to be able to collect data for the entire chef-client run, Reporting needs to be enabled before anything else happens at the start of the chef-client run.
