.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In many cases, it is better to use the ``service`` |inspec resource| resource instead of this one. This is because when the ``service`` resource is used in a control, |inspec| will use platform details to determine the correct service manager. Using the ``service`` |inspec resource| allows a control to be authored in a way that allows it to be used across many platforms.
