+++
title = "Deprecation: Verify File Expansion (CHEF-7)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"
sitemapExclude = true
aliases = "/deprecations_verify_file.html"
+++

The `verify` metaproperty allows the user to specify a `{path}` variable
that's expanded to the path of the file to be verified. Previously, it
was possible to use `{file}` as the variable, but that's now
deprecated.

The `{file}` expansion was deprecated in Chef Infra Client 12.5, and will be
removed in Chef Infra Client 13.

## Example

```ruby
file '/etc/nginx.conf' do
  verify 'nginx -t -c %{file}'
end
```

## Remediation

Replace `%{file}` with `%{path}`:

```ruby
file '/etc/nginx.conf' do
  verify 'nginx -t -c %{path}'
end
```
