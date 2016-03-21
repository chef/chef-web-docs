.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

After the instance has been provisioned and initial configuration has completed (usually 10 to 13 minutes) run through the setup wizard to create your user and register for a |company_name| support account. To complete the configuration, do the following:

#. Access the |chef server| setup wizard.  Build the URL by prepending ``https://`` and appending ``/signup`` to the IP address or public hostname that was automatically assigned when the |amazon ami| was launched.  For example, ``https://<fqdn>/signup``.

   .. note:: .. include:: ../../includes_notes/includes_notes_chef_aws_ssl.rst

#. Run through the setup wizard. If you opt into creating a support account you should receive a confirmation email for a Hosted Chef account. Follow the link in the confirmation email to complete the support account creation.
