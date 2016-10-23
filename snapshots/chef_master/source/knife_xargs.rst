=====================================================
knife xargs
=====================================================

.. include:: ../../includes_knife/includes_knife_xargs.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_xargs_syntax.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

.. include:: ../../includes_knife/includes_knife_xargs_options.rst

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Find, and then replace data**

The following example will go through all nodes on the server, and then replace the word ``foobar`` with ``baz``:

.. code-block:: bash

   $ knife xargs --pattern /nodes/* "perl -i -pe 's/foobar/baz'"

**Use output of knife list and Perl**

The following examples show various ways of listing all nodes on the server, and then using Perl to replace ``grantmc`` with ``gmc``:

.. code-block:: bash

   $ knife list 'nodes/*' | knife xargs "perl -i -pe 's/grantmc/gmc'"

or without quotes and the backslash escaped:

.. code-block:: bash

   $ knife list /nodes/\* | knife xargs "perl -i -pe 's/grantmc/gmc'"

or by using the ``--pattern`` option:

.. code-block:: bash

   $ knife xargs --pattern '/nodes.*' "perl -i -pe 's/grantmc/gmc'"

**View security groups data**

The following example shows how to display the content of all groups on the server:

.. code-block:: bash

   $ knife xargs --pattern '/groups/*' cat

and will return something like:

.. code-block:: javascript

   {
     "name": "4bd14db60aasdfb10f525400cdde21",
     "users": [
       "grantmc"
     ]
   }{
     "name": "62c4e268e15fasdasc525400cd944b",
     "users": [
       "robertf"
     ]
   }{
     "name": "admins",
     "users": [
       "grantmc",
       "robertf"
     ]
   }{
     "name": "billing-admins",
     "users": [
       "dtek"
     ]
   }{
     "name": "clients",
     "clients": [
       "12345",
       "67890",
     ]
   }{
     "name": "users",
     "users": [
       "grantmc"
       "robertf"
       "dtek"
     ],
     "groups": [
       "4bd14db60aasdfb10f525400cdde21",
       "62c4e268e15fasdasc525400cd944b"
     ]
   }
