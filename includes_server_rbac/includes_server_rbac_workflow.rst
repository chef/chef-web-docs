.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


When a user makes a request to the |chef server| using the |api chef server|, permission to perform that action is determined by the following process:

#. Check if the user has permission to the object type
#. If no, recursively check if the user is a member of a security group that has permission to that object 
#. If yes, allow the user to perform the action

Permissions are managed using the |chef manage| add-on in the |chef server| web user interface.