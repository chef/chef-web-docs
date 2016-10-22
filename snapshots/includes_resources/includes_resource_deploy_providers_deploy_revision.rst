.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``deploy_revision`` provider is the recommended provider, even if it is not listed as the default. The ``deploy_revision`` provider is used to ensure that the name of a release sub-directory is based on a revision identifier. For users of git, this will be the familiar SHA checksum. For users of Subversion, it will be the integer revision number. If a name other than a revision identifier is provided---branch names, tags, and so on---the chef-client will ignore the alternate names and will look up the revision identifier and use it to name the release sub-directory. When the ``deploy_revision`` provider is given an exact revision to deploy, it will behave in an idempotent manner. 

The ``deploy_revision`` provider results in deployed components under the destination location that is owned by the user who runs the application. This is sometimes an issue for certain workflows. If issues arise, consider the following: 

* Incorporate changing permissions to the desired end state from within a recipe
* Add a ``before_restart`` block to fix up the permissions
* Have an unprivileged user (for example: ``opscode``) be the owner of the ``deploy`` directory and another unprivileged user (for example: ``opscodeapp``) run the application. Most often, this is the solution that works best

When using the ``deploy_revision`` provider, and when the deploy fails for any reason, and when the same code is used to re-deploy, the action should be set manually to ``:force_deploy``. Forcing the re-deploy will remove the old release directory, after which the deploy can proceed as usual. (Forcing a re-deploy over the current release can cause some downtime.) Deployed revisions are stored in ``(file_cache_path)/revision-deploys/(deploy_path)``.
