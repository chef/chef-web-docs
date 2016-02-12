.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following resource tests |ssh| server configuration. For example, a simple control may be desrcibed as:

.. code-block:: ruby

   describe sshd_config do
     its('Port') { should eq('22') }
   end

In various use cases like implementing IT compliance across different departments, it becomes handy to extend the control with metadata. Each control may define an additional ``impact``, ``title`` or ``desc``. An example looks like:

An |inspec resource| block declares a directory and the permissions needed on that directory. For example:

.. code-block:: ruby

   control 'sshd-8' do
     impact 0.6
     title 'Server: Configure the service port'
     desc '
       Always specify which port the SSH server should listen to.
       Prevent unexpected settings.
     '
     describe sshd_config do
       its('Port') { should eq('22') }
     end
   end

where

* ``'sshd-8'`` is the name of the rule
* ``impact``, ``title``, and ``desc`` define metadata that fully describes the importance of the control, its purpose, with a succinct and complete description; these three methods display their data in the |chef compliance| web user interface
* ``impact`` is a float that measures the importance of the compliance results and must be a value between ``0.0`` and ``1.0``.
* ``describe`` is a block that contains at least one test. A ``control`` block must contain at least one ``describe`` block, but may contain as many as required
* ``sshd_config`` is an |inspec resource|. For the full list, see https://docs.chef.io/inspec_reference.html.
* ``its('Port')`` is the matcher; ``{ should eq('22') }`` is the test. A ``describe`` block must contain at least one matcher, but may contain as many as required

.. note:: It is recommended that test files are located in the ``/tests`` directory. When writing rules, the ``impact``, ``title``, ``desc`` metadata are optional, but are highly recommended.
