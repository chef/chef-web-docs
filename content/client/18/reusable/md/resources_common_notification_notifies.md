A resource may notify another resource to take action when its state
changes. Specify a `'resource[name]'`, the `:action` that resource
should take, and then the `:timer` for that action. A resource may
notify more than one resource; use a `notifies` statement for each
resource to be notified.

If the referenced resource doesn't exist, an error is raised.
In contrast, `subscribes` won't fail if the source
resource isn't found.
