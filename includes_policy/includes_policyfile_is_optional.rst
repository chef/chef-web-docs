.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


|policyfile| is an optional and may be used alongside all existing functionality in the |chef client|, the |chef dk|, and the |chef server|. |policyfile| supports:

* Single and monolithic cookbook repo patterns
* Versioning via the |policylock| file, against which an opaque identifier is associated
* Naming policy groups after workflow deployment phases, such as ``dev``, ``stage``, ``prod``, and ``canary`` 
* Associating each policy group with an active version, such as revision ``123abc`` of the ``webapp`` policy, which is applied to the ``dev`` policy group; once validated and tested, the active version may then be applied to ``stage``, and then ``prod``, after which development might continue on the ``456def`` revision
* Environments via nested attributes. For example: ``default["production"]["app_setting"] = "prod value"`` and ``default["dev"]["app_setting"] = "dev value"``, where ``["app_setting"]`` is effectively the environment value
* Using data bag items to pull certain attribute values, when necessary
