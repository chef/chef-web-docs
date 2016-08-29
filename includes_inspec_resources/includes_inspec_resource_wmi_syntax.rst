.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``wmi`` |inspec resource| block tests the output of a |vbscript| on the |windows| platform:

.. code-block:: ruby

   describe wmi({
     class: 'class_name'
     namespace: 'path\\to\\setting'
     filter: 'filter'
     query: 'query'
   }) do
     its('setting_name') { should eq '' }
   end

where

* ``class``, ``namespace``, ``filter``, and ``query`` comprise a |ruby hash| of the WMI object
* ``('class')`` is the WMI class to which the setting belongs, such as ``win32_service``
* ``('namespace')`` is path to that object, such as ``root\\cimv2``
* Use ``('filter')`` fine-tune the information defined by the WMI class, such as to find a specific service (``filter: "name like '%winrm%'")``, to find a specific setting (``filter: 'KeyName = \'MinimumPasswordAge\' And precedence=1'``), and so on
* Use ``('query')`` to run a query that returns data to be tested, such as ``"SELECT Setting FROM RSOP_SecuritySettingBoolean WHERE KeyName='LSAAnonymousNameLookup' AND Precedence=1"``
* ``('setting_name')`` is a setting in the WMI object to be tested, and then ``should eq ''`` is the expected value for that setting

For example, both of the following tests will verify if |winrm| is present on the target node. The first tests if |winrm| belongs to the list of services running under the ``win32_service`` class:

.. code-block:: ruby

   describe wmi({class: 'win32_service'}) do
     its('DisplayName') { should include 'Windows Remote Management (WS-Management)'}
   end

and the second uses a filter in the |ruby hash| to first identify |winrm|, and then perform additional tests:

.. code-block:: ruby

   describe wmi({
     class: 'win32_service',
     filter: "name like '%winrm%'"
   }) do
     its('Status') { should cmp 'ok' }
     its('State') { should cmp 'Running' }
     its('ExitCode') { should cmp 0 }
     its('DisplayName') { should eq 'Windows Remote Management (WS-Management)'}
   end
