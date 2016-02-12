.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef delivery| encapsulates the entire development process: 

* Make changes to cookbooks, review and approve them with your team
* Deliver that cookbook to source control, after which |chef delivery| will build it, and then test it
* Applications typically comprise many cookbooks. |chef delivery| uses a phase called "Union" to build all of those cookbooks together, and then test them together
* Preview those changes to make sure they are the changes you want
* Deliver those changes!
