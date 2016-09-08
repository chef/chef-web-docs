=====================================================
|inspec| Profiles
=====================================================

|inspec| supports the creation of complex test and compliance profiles, which organize controls to support dependency management and code reuse. Each profile is a standalone structure with its own distribution and execution flow.

Profile Structure
=====================================================
A profile should have the following structure::

   examples/profile
   ├── README.md
   ├── controls
   │   ├── example.rb
   │   └── control_etc.rb
   ├── libraries
   │   └── extension.rb
   └── inspec.yml

where:

* ``inspec.yml`` includes the profile description (required)
* ``controls`` is the directory in which all tests are located (required)
* ``libraries`` is the directory in which all InSpec resource extensions are located (optional)
* ``README.md`` should be used to explain the profile, its scope, and usage

See `a complete example profile <https://github.com/chef/inspec/tree/master/examples/profile>`__ in the InSpec open source repository.

inspec.yml
-----------------------------------------------------
Each profile must have an ``inspec.yml`` file that defines the following information:

 * Use ``name`` to specify a unique name for the profile. Required.
 * Use ``title`` to specify a human-readable name for the profile.
 * Use ``maintainer`` to specify the profile maintainer.
 * Use ``copyright`` to specify the copyright holder.
 * Use ``copyright_email`` to specify support contact information for the profile, typically an email address.
 * Use ``license`` to specify the license for the profile.
 * Use ``summary`` to specify a one line summary for the profile.
 * Use ``description`` to specify a multiple line description of the profile.
 * Use ``version`` to specify the profile version.
 * Use ``supports`` to specify a list of supported platform targets.
 * Use ``depends`` to define a list of profiles on which this profile depends.

``name`` is required; all other profile settings are optional. For example:

.. code-block:: yaml

   name: ssh
   title: Basic SSH
   maintainer: Chef Software, Inc.
   copyright: Chef Software, Inc.
   copyright_email: support@chef.io
   license: Proprietary, All rights reserved
   summary: Verify that SSH Server and SSH Client are configured securely
   version: 1.0.0
   supports:
     - os-family: linux
   depends:
     - name: profile
       path: ../path/to/profile


Verify Profiles
-----------------------------------------------------
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_check_example_verify_profile.rst


Platform Support
=====================================================
Use the ``supports`` setting in the ``inspec.yml`` file to specify one (or more) platforms for which a profile is targeting. The list of supported platforms may contain simple names, names and versions, or detailed flags, and may be combined arbitrarily. For example, to target anything running |debian| |linux|:

.. code-block:: yaml

   name: ssh
   supports:
     - os-name: debian

and to target only |ubuntu| version 14.04

.. code-block:: yaml

   name: ssh
   supports:
     - os-name: ubuntu
       release: 14.04

and to target the entire |redhat| platform (including |centos| and |oracle linux|):

.. code-block:: yaml

   name: ssh
   supports:
     - os-family: redhat

and to target anything running on |amazon aws|:

.. code-block:: yaml

   name: ssh
   supports:
     - platform: aws

and to target all of these examples in a single ``inspec.yml`` file:

.. code-block:: yaml

   name: ssh
   supports:
     - os-name: debian
   supports:
     - os-name: ubuntu
       release: 14.04
   supports:
     - os-family: redhat
   supports:
     - platform: aws



Profile Dependencies
=====================================================
Use the ``depends`` setting in the ``inspec.yml`` file to specify one (or more) profiles on which this profile depends. A profile dependency may be sourced from a path, URL, a |git| repo, a cookbook located on |supermarket| or on |github|.

Path
-----------------------------------------------------
The ``path`` setting defines a profile that is located on disk. This setting is typically used during development of profiles and when debugging profiles. This setting does not support version constraints. If the location of the profile does not exist, an error is returned.

For example:

.. code-block:: yaml

   depends:
   - name: my-profile
     path: /absolute/path
   - name: another
     path: ../relative/path


URL
-----------------------------------------------------
The ``url`` setting specifies a profile that is located at an HTTP- or HTTPS-based URL. The profile must be accessible via a HTTP GET operation and must be a valid profile archive (zip, tar, tar.gz format). If the download fails, the profile is inaccessible, or not in the correct format, an error is returned.

For example:

.. code-block:: yaml

   depends:
   - name: my-profile
     url: https://my.domain/path/to/profile.tgz


|git|
-----------------------------------------------------
A ``git`` setting specifies a profile that is located in a |git| repository, with optional settings for branch, tag, commit, and version. The source location is translated into a URL upon resolution. This type of dependency supports version indexing via semantic versioning as |git| tags.

For example:

.. code-block:: yaml

   depends:
   - name: git-profile
     git: http://url/to/repo
     branch:  desired_branch
     tag:     desired_version
     commit:  pinned_commit
     version: semver_via_tags


|supermarket|
-----------------------------------------------------
A ``supermarket`` setting specifies a profile that is located in a cookbook hosted on |supermarket|, with optional settings for branch, tag, commit, and version. The source location is translated into a URL upon resolution. This type of dependency supports version indexing via semantic versioning as |git| tags.

For example:

.. code-block:: yaml

   depends:
   - name: supermarket-profile
     git: username/profile
     branch:  desired_branch
     tag:     desired_version
     commit:  pinned_commit
     version: semver_via_tags


|github|
-----------------------------------------------------
A ``github`` setting specifies a profile that is located in a repository hosted on |github|, with optional settings for branch, tag, commit, and version. The source location is translated into a URL upon resolution. This type of dependency supports version indexing via semantic versioning as |git| tags.

For example:

.. code-block:: yaml

   depends:
   - name: gh-profile
     git: username/project
     branch:  desired_branch
     tag:     desired_version
     commit:  pinned_commit
     version: semver_via_tags


Profile Inheritance
=====================================================
The ``include_controls`` keyword may be used in a profile to import all rules from the named profile. For example, to include controls from a profile:

.. code-block:: bash

   include_controls 'cis-level-1' do
   
     control "cis-fs-2.7" do
       impact 1.0
     ...
   
   end

or to include controls from a profile, but skip some rules:

.. code-block:: bash

   include_controls 'cis-level-1' do
   
     skip_control "cis-fs-2.1"
     skip_control "cis-fs-2.2"
   
   end

Use the ``require_controls`` keyword to load specific controls from the named profile:

.. code-block:: bash

   require_controls 'cis-level-1' do
   
     control "cis-fs-2.1"
     control "cis-fs-2.2"
   
   end


Profile Archives
=====================================================
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_archive.rst

**Create a profile archive as zip**

.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_archive_example_zip.rst

**Create a profile archive as tar**

.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_archive_example_tar.rst

