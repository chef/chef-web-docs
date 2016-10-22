.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


Custom Resources are:

A method of extending of |chef| to create your own custom resources that help to automate common patterns used in your cookbooks.

Custom resources can:

Utilize built in |chef| resources allowing you to reduce code duplication across multiple cookbooks. They can also contain arbitrary Ruby code from core Ruby or 3rd party gems. This allows for the creation of resources that could interact with system functionality such as RAID controllers, or external systems such as cloud provider API services.
