.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The syntax for a Chef Analytics rule is as follows:

.. code-block:: none

   rules 'name'
     with priority=n
     rule 'name' on message_type
     when
       // comment
       function()
     then
       // comment
       function()
     otherwise
       // comment
       function()
     end
   
     rule ...
       ...
     end
   
     ...
   end

where:

* ``rules`` defines a rules group which is comprised of individual rules (``rule``)
* ``rule`` defines an individual rule; each rule must be contained in its own ``rule`` block
* ``with priority=n`` is a positive or negative integer that defines the relative priority of a rules group as compared to all other rules groups
* ``'name'`` is name of the rule group and/or the name of the rule; required for ``rules``, optional for each ``rule``
* ``message_type`` is one of the following: ``action``, ``run_control``, ``run_control_group``, ``run_converge``, ``run_resource``, or ``run_start``
* ``when`` is a series of evaluations that result in ``true`` or ``false``
* ``then`` is a comma-separated group of statements that are used to test data
* ``otherwise`` is a comma-separated group of statements that are used to test data
* ``function()`` is a statement that tests a value in the JSON object; functions may be one of ``array:contains()``, ``alert:<level>()``, ``datetime:component()``, ``get()``, ``log()``, or ``mustache_template()``. (See "Functions" below for more information about the individual functions.)
* A comment starts with two forward slashes--``//``---and continues to the end of the line on which the comment begins
* Whitespace is ignored by the rules parser unless it contained within single- or double-quoted strings. For example, the parser will preserve the white space in ``'white space'`` and ``"white space"``
