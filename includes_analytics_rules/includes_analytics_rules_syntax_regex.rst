.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use a regular expression to define a search pattern to match against a rule. Use the ``=~`` operator to define the regular expression:

.. code-block:: ruby

   string_to_match =~ regular_expression

For example:

.. code-block:: ruby

   rules 'regex demo'
     rule on action
       when
         // match if the user_agent starts with the string 'Chef Manage'
         user_agent =~ 'Chef Manage.*'
           or 
         // match 1 or more lower case characters followed by a single digit
         entity_name =~ '[a-z]+\d'
       then
         nofity('my_webhook')
     end
   end

Use the following to match contstructs:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Construct
     - Description
   * - ``x``
     - Use to match the ``x`` character.
   * - ``\``
     - Use to match the backslash character.
   * - ``\t``
     - Use to match the tab character (``'\u0009'``).
   * - ``\n``
     - Use to match the newline (line feed) character (``'\u000A'``).
   * - ``\r``
     - Use to match the carriage-return character (``'\u000D'``).

Use the following to match characters:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Characters
     - Description
   * - ``[abc]``
     - Use to match a, b, or c.
   * - ``[^abc]``
     - Use to match any character except a, b, or c.
   * - ``[a-zA-Z]``
     - Use to match a through z or A through Z, inclusive.
   * - ``.``
     - Use to match any character or a line terminator.
   * - ``\d``
     - Use to match a digit. For example: ``[0-9]``.
   * - ``\D``
     - Use to match a non-digit. For example: ``[^0-9]``.
   * - ``\s``
     - Use to match a whitespace character. For example: ``[ \t\n\x0B\f\r]``.
   * - ``\S``
     - Use to match a non-whitespace character. For example: ``[^\s]``.
   * - ``\w``
     - Use to match a word character. For example: ``[a-zA-Z_0-9]``.
   * - ``\W``
     - Use to match a non-word character. For example: ``[^\w]``.

Use the following to match boundaries:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Boundary
     - Description
   * - ``^``
     - Use to match the beginning of a line.
   * - ``$``
     - Use to match the end of a line.
   * - ``\b``
     - Use to match a word boundary.
   * - ``\B``
     - Use to match a non-word boundary.	 
