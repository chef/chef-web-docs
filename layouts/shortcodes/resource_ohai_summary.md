Use the **ohai** resource to reload the Ohai configuration on a node.
This allows recipes that change system attributes (like a recipe that
adds a user) to refer to those attributes later on during a Chef Infra
Client run.