You should provide the install options as a hash if you are not using an explicit
`gem_binary` parameter with the `gem_package` resource. This approach allows the
provider to install the gem without needing to spawn an external gem process.

The following RubyGems options are available for inclusion within a hash
and are passed to the RubyGems DependencyInstaller:

- `:env_shebang`
- `:force`
- `:format_executable`
- `:ignore_dependencies`
- `:prerelease`
- `:security_policy`
- `:wrappers`

For more information about these options, see the RubyGems
documentation:
<https://docs.ruby-lang.org/en/2.2.0/Gem/DependencyInstaller.html>.