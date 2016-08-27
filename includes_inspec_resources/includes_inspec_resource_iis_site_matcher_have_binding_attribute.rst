.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``have_binding`` matcher can also test attributes that are defined for a site binding. For example, the ``sslFlags`` attribute defines if SSL is enabled, and (when enabled) what level of SSL is applied to the site.

Testing a site with SSL disabled:

.. code-block:: ruby

   it { should have_binding('https :443:www.contoso.com sslFlags=0') }

Testing a site with SSL enabled:

.. code-block:: ruby

   it { should have_binding('https :443:www.contoso.com sslFlags=Ssl') }

Testing a site with certificate mapping authentication enabled:

.. code-block:: ruby

   it { should have_binding('https :443:www.contoso.com sslFlags=SslMapCert') }

Testing a site with 128-bit SSL enabled:

.. code-block:: ruby

   it { should have_binding('https :443:www.contoso.com sslFlags=Ssl128') }

