.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Reason**

Cannot connect to |postgresql| on the remote server.

**Possible Causes**

* |postgresql| is not running on the remote server
* The port used by |postgresql| is blocked by a firewall on the remote server
* Network routing configuration is preventing access to the host
* When using |amazon aws|, rules for security groups are preventing the |chef server| from communicating with |postgresql|
