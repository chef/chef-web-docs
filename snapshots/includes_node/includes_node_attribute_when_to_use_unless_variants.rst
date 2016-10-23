.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Another (much less common) approach is to set a value only if an attribute has no value. This can be done by using the ``_unless`` variants of the attribute priority methods:

* ``default_unless``
* ``set_unless`` (``normal_unless`` is an alias of ``set_unless``; use either alias to set an attribute with a normal attribute precedence.) 

    .. note:: This method was deprecated in Chef client 12.12 and will be removed in Chef 14. Please use ``default_unless`` or ``override_unless`` instead.

* ``override_unless`` 

.. note:: Use the ``_unless`` variants carefully (and only when necessary) because when they are used, attributes applied to nodes may become out of sync with the values in the cookbooks as these cookbooks are updated. This approach can create situations where two otherwise identical nodes end up having slightly different configurations and can also be a challenge to debug. 
