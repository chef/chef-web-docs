Every cookbook requires a small amount of metadata.
The contents of the `metadata.rb` file provides information that helps Chef Infra Client and Server correctly deploy cookbooks to each node.

A `metadata.rb` file is:

- Located at the top level of a cookbook's directory structure.
- Compiled whenever a cookbook is uploaded to the Chef Infra Server or when the `knife cookbook metadata` subcommand is run, and then stored as JSON data.
- Created automatically by knife whenever the `knife cookbook create` subcommand is run.
- Edited using a text editor, and then re-uploaded to the Chef Infra Server as part of a cookbook upload.
