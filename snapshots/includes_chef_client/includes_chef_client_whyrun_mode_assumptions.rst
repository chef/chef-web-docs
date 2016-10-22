.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


When the chef-client is run in why-run mode, certain assumptions are made:

* If the **service** resource cannot find the appropriate command to verify the status of a service, why-run mode will assume that the command would have been installed by a previous resource and that the service would not be running
* For ``not_if`` and ``only_if`` attribute, why-run mode will assume these are commands or blocks that are safe to run. These conditions are not designed to be used to change the state of the system, but rather to help facilitate idempotency for the resource itself. That said, it may be possible that these attributes are being used in a way that modifies the system state
* The closer the current state of the system is to the desired state, the more useful why-run mode will be. For example, if a full run-list is run against a fresh system, that run-list may not be completely correct on the first try, but also that run-list will produce more output than a smaller run-list
