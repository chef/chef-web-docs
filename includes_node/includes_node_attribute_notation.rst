.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Attributes are a special key-value store (called a |ruby mash|) within the context of the |ruby| DSL. A |ruby mash| is just a |ruby hash| where the key can be either a symbol (:key) or a string ('key'). 

.. note:: Individuals who are new to |ruby| and |chef| may have an easier time using only string notation. This approach allows attributes to 'be single quoted' and "be double quoted" and does not require learning about special cases, namespace overlap (and ``method_missing``), character constraints, and escaping.
