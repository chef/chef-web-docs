.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A driver-specific resource is a statement of configuration policy that:

* Describes the desired state for a configuration item that is created using Chef provisioning
* Declares the steps needed to bring that item to the desired state
* Specifies a resource type---such as ``package``, ``template``, or ``service`` 
* Lists additional details (also known as properties), as necessary
* Are grouped into recipes, which describe working configurations
