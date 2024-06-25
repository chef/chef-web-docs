Chef Infra Client supports reading multiple configuration files by
putting them inside a `.d` configuration directory. For example:
`/etc/chef/client.d`. All files that end in `.rb` in the `.d` directory
are loaded; other non-`.rb` files are ignored.

Chef Infra Client itself requires that .rb files are stored in a directory named `client.d`, such as

- `/etc/chef/client.d`

Chef development tooling such as knife requires that .rb files are stored in a directory named `config.d`, such as

- `~/.chef/config.d`

Chef Solo requires that .rb files are stored in a directory named `solo.d`, such as

- `~/chef/solo.d`

(There is no support for a `knife.d` directory; use `config.d` instead.)

For example, when using knife, the following configuration files would
be loaded:

- `~/.chef/config.rb`
- `~/.chef/config.d/company_settings.rb`
- `~/.chef/config.d/ec2_configuration.rb`
- `~/.chef/config.d/old_settings.rb.bak`

The `old_settings.rb.bak` file is ignored because it is not a
configuration file. The `config.rb`, `company_settings.rb`, and
`ec2_configuration` files are merged together as if they are a single
configuration file.

<!-- markdownlint-disable-file MD033 -->

<div class="admonition-note">
<p class="admonition-note-title">Note</p>
<div class="admonition-note-text">

If multiple configuration files exists in a `.d` directory, ensure that
the same setting has the same value in all files.

</div>
</div>
