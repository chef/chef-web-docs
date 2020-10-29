A resource may notify another resource to take action when its state
changes. Specify a `'resource[name]'`, the `:action` that resource
should take, and then the `:timer` for that action. A resource may
notify more than one resource; use a `notifies` statement for each
resource to be notified.

If the resource referenced does not exist, an error is raised.
Contrast with `subscribes` which does not fail if the source
resource is not found.
