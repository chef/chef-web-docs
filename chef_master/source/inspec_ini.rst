=====================================================
ini
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_ini.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_ini_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_no_matchers.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test SMTP settings in a PHP INI file**

For example, a |php| INI file located at contains the following settings:

.. code-block:: ruby

   ; SMTP = smtp.gmail.com
   ; smtp_port = 465

and can be tested like this:

.. code-block:: ruby

   describe ini(/etc/php5/apache2/php.ini) do
     its('smtp_port') { should eq('465') }
   end
