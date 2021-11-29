The `templates` directory does not exist by default in a cookbook.
Generate the `templates` directory and a template file from the `chef-repo/cookbooks` directory with the command:

```bash
chef generate template PATH_TO_COOKBOOK TEMPLATE_NAME
```

For example, this command generates a `httpd` template in the `custom_web` cookbook:

```bash
chef generate template cookbooks/custom_web httpd
```

The `custom_web` cookbook directory with a template has the structure:


```text
├ cookbooks
 ├ custom_web
 | ├ .delivery
 | | └ project.toml
 | ├ recipes
 | | └ default.rb
 | ├ templates
 | | └ http.erb
 | ├ test
 | | └ integration
 | | | └ default
 | | | | └ default_test.rb
 | ├ .gitignore
 | ├ CHANGELOG.md
 | ├ chefignore
 | ├ kitchen.yml
 | ├ LICENSE
 | ├ metadata.rb
 | ├ Policyfile.rb
 | └ README.md
```
