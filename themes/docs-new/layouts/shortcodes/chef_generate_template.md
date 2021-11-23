The `templates` directory does not exist by default in a cookbook.
Generate the `templates` directory and a template file from the `chef-repo/cookbooks` directory with the command:

```bash
chef generate template cookbook filename.erb
```

For example, this command generates the `templates` directory that contains a file named `httpd` in the `webserver` cookbook:

```
chef generate resource webserver http.conf.erb
```

The `webserver` cookbook directory has the structure:

```output
├ cookbooks
| ├ webserver
  | ├ attribtes
  | | └ default.rb
  | ├ recipes
  | | └ default.rb
  | ├ templates
  | | └ http.conf.erb
  └ README.md
  └ metadata.rb
```
