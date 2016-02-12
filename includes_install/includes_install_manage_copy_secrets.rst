.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This updates the |chef server| and creates the ``/etc/opscode-manage/secrets.rb`` file. When running the |chef manage| 1.11 (or higher), copy the ``secrets.rb`` file in the ``/etc/opscode-manage`` directory on one of the frontend servers to the same directory on each of the other frontend servers, and then rerun ``opscode-manage-ctl reconfigure`` so the copied ``/etc/opscode-manage/secrets.rb`` file gets used correctly.
