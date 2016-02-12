.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``ha``:

``ha['aws_access_key_id']``
   |aws_access_key_id|

``ha['aws_secret_access_key']``
   |aws_access_key_secret|

``ha['ebs_volume_id']``
   The identifier for the |amazon ebs| volume.

``ha['provider']``
   The provider that is used for a high availability configuration. Possible values: ``drbd``, ``aws``. Use ``aws`` to configure the |chef server| for high availability using |amazon aws|. Use ``drbd`` to configure the |chef server| for high availability using |drbd|. Default value: ``drbd``.
