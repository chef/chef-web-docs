.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the |subcommand knife upload| subcommand to upload data to the  |chef server| from the current working directory in the |chef repo|. The following types of data may be uploaded with this subcommand:

* Cookbooks
* Data bags
* Roles stored as |json| data
* Environments stored as |json| data

(Roles and environments stored as |ruby| data will not be uploaded.) This subcommand is often used in conjunction with ``knife diff``, which can be used to see exactly what changes will be uploaded, and then ``knife download``, which does the opposite of ``knife upload``.
