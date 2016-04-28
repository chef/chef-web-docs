.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To install a private |supermarket| use the ``supermarket-omnibus-cookbook``. This cookbook is `available from the public <https://supermarket.chef.io/cookbooks/supermarket-omnibus-cookbook>`__ |supermarket|.

* The ``supermarket-omnibus-cookbook`` cookbook is attribute-driven; use a custom cookbook to specify your organization's unique ``node[supermarket_omnibus]`` attribute values.
* The custom cookbook is a wrapper around ``supermarket-omnibus-cookbook``, which performs the actual installation of the |supermarket| packages, and then writes the custom ``node[supermarket_omnibus]`` values to ``/etc/supermarket/supermarket.json``.
* The |supermarket| package itself contains an internal cookbook which configures the already-installed package using the attributes defined in ``/etc/supermarket/supermarket.json``.
