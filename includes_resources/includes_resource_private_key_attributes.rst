.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``cipher``
   Use to specify the cipher for a .pem file. Default value: ``DES-EDE3-CBC``.
   
``exponent``
   Use to specify the exponent for an RSA private key. This is always an odd integer value, often a prime Fermat number, and typically ``5``, ``17``, ``257``, or ``65537``.
   
``format``
   Use to specify the format of a private key. Possible values: ``pem`` and ``der``. Default value: ``pem``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst
   
``pass_phrase``
   Use to specify the pass phrase for a .pem file.
   
``path``
   Use to specify the path to a private key. Set to ``none`` to create a private key in-memory and not on-disk. Default value: the ``name`` of the resource block. |see syntax|
   
``public_key_format``
   Use to specify the format of a public key. Possible values: ``der``, ``openssh``, and ``pem``. Default value: ``openssh``.
   
``public_key_path``
   The path to a public key.
   
``regenerate_if_different``
   Use to regenerate a private key if it does not have the desired size, type, and so on. Default value: ``false``.
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``size``
   Use to specify the size of an RSA or DSA private key. Default value: ``2048``.
   
``source_key``
   Use to copy a private key, but apply a different ``format`` and ``password``. Use in conjunction with ``source_key_pass_phrase``` and ``source_key_path``.
   
``source_key_pass_phrase``
   The pass phrase for the private key. Use in conjunction with ``source_key``` and ``source_key_path``.
   
``source_key_path``
   The path to the private key. Use in conjunction with ``source_key``` and ``source_key_pass_phrase``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|
   
``type``
   Use to specify the type of private key. Possible values: ``dsa`` and ``rsa``. Default value: ``rsa``.
