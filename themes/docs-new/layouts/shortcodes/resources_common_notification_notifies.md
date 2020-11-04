A resource may notify another resource to take action when its state
changes. Specify a `'resource[name]'`, the `:action` that resource
should take, and then the `:timer` for that action. A resource may
notify more than one resource; use a `notifies` statement for each
resource to be notified.

If the referenced resource does not exist, an error is raised.
In contrast, `subscribes` will not fail if the source
resource is not found.
