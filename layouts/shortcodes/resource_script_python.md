Use the **python** resource to execute scripts using the Python
interpreter. This resource may also use any of the actions and
properties that are available to the **execute** resource. Commands that
are executed with this resource are (by their nature) not idempotent, as
they are typically unique to the environment in which they are run. Use
`not_if` and `only_if` to guard this resource for idempotence.

<div class="alert-info">

The **python** script resource (which is based on the **script**
resource) is different from the **ruby_block** resource because Ruby
code that is run with this resource is created as a temporary file and
executed like other script resources, rather than run inline.

</div>