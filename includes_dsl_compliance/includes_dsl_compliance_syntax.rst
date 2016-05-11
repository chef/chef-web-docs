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
     tag "tag_name"
     ref "name", url: "https://..."
     describe sshd_config do
       its('Port') { should eq('22') }
     end
   end

where

* ``'sshd-8'`` is the name of the rule
* ``impact``, ``title``, and ``desc`` define metadata that fully describes the importance of the control, its purpose, with a succinct and complete description; these three methods display their data in the |chef compliance| web user interface
* ``impact`` is a float that measures the importance of the compliance results and must be a value between ``0.0`` and ``1.0``.
* ``tag`` is optional meta information to provide context for the control. This may be a simple value or a more complex key-value pair, such as ``security: "openssh-server"``
* ``ref`` is a reference to a document with an (optional) URL to that document
* ``describe`` is a block that contains at least one test. A ``control`` block must contain at least one ``describe`` block, but may contain as many as required
* ``sshd_config`` is an |inspec resource|. For the full list, see https://docs.chef.io/inspec_reference.html.
* ``its('Port')`` is the matcher; ``{ should eq('22') }`` is the test. A ``describe`` block must contain at least one matcher, but may contain as many as required

For example, a set of controls that check the |ssh| server configuration:

.. code-block:: ruby

   # encoding: utf-8

   # Skip all controls, if SSH doesn't exist on the system
   only_if do
     command('sshd').exist?
   end
   
   control "sshd-11" do
     impact 1.0
     title "Server: Set protocol version to SSHv2"
     desc "Set the SSH protocol version to 2. Don't use legacy
           insecure SSHv1 connections anymore."
     tag security: "openssh-server"
     ref "Document A-12"
   
     describe sshd_config do
       its('Protocol') { should eq('2') }
     end
   end
   
   control "sshd-7" do
     impact 1.0
     title "Server: Do not permit root-based login with password."
     desc "To reduce the potential to gain full privileges
           of a system in the course of an attack (by either misconfiguration
           or vulnerabilities), do not allow login as root with password"
     tag security: "openssh-server"
     ref "Document A-12"
   
     describe sshd_config do
       its('PermitRootLogin') { should match(/no|without-password/) }
     end
   end



.. note:: It is recommended that test files are located in the ``/tests`` directory. When writing rules, the ``impact``, ``title``, ``desc`` metadata are optional, but are highly recommended.
