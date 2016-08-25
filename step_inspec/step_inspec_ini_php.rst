.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To verify the settings in php.ini:

For example, a |php| INI file located at contains the following settings:

.. code-block:: ruby

   ; SMTP = smtp.gmail.com
   ; smtp_port = 465

and can be tested like this:

.. code-block:: ruby

   describe ini(/etc/php5/apache2/php.ini) do
     its('smtp_port') { should eq('465') }
   end
