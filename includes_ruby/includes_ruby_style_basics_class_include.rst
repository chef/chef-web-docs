.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``:include`` to include another |ruby| class. For example:

.. code-block:: ruby

   ::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

In non-|chef| |ruby|, the syntax is ``include`` (without the ``:`` prefix), but without the ``:`` prefix the |chef client| will try to find a provider named ``include``. Using the ``:`` prefix tells the |chef client| to look for the specified class that follows.
