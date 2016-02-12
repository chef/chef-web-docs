.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use a |rubocop yml| file in a cookbook to override the default settings in |rubocop| for enabled and disabled rules. Only enabled rules---either in the ``enabled.yml`` file in |rubocop| itself or rules that are specifically enabled in a cookbook's |rubocop yml| file---will be used during the evaluation. Any rule that becomes unhelpful should be disabled in the |rubocop yml| file.
