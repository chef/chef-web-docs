.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get the details for a tool.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /tools/TOOL_SLUG

**Response**

The response will return details for a tool, including the name of the tool, a type, description, owner, source URL and install instructions as markdown:

.. code-block:: javascript

    {
      "name": "Berkshelf",
      "slug": "berkshelf",
      "type": "chef_tool",
      "source_url": "https://github.com/berkshelf/berkshelf",
      "description": "A Chef Cookbook manager",
      "instructions": "# Berkshelf\r\n[![Gem Version](https://img.shields.io/gem/v/berkshelf.svg)][gem]\r\n[![Build Status](https://img.shields.io/travis/berkshelf/berkshelf.svg)][travis]\r\n\r\n[gem]: https://rubygems.org/gems/berkshelf\r\n[travis]: https://travis-ci.org/berkshelf/berkshelf\r\n\r\nManage a Cookbook or an Application's Cookbook dependencies\r\n\r\n## Installation\r\n\r\nBerkshelf is now included as part of the [Chef-DK](http://chef.io/downloads/chef-dk). This is fastest, easiest, and the recommended installation method for getting up and running with Berkshelf.\r\n\r\n> note: You may need to uninstall the Berkshelf gem especially if you are using a Ruby version manager you may need to uninstall all Berkshelf gems from each Ruby installation.\r\n\r\n### From Rubygems\r\n\r\nIf you are a developer or you prefer to install from Rubygems, we've got you covered.\r\n\r\nAdd Berkshelf to your repository's `Gemfile`:\r\n\r\n```ruby\r\ngem 'berkshelf'\r\n```\r\n\r\nOr run it as a standalone:\r\n\r\n    $ gem install berkshelf\r\n\r\n## Usage\r\n\r\nSee [berkshelf.com](http://berkshelf.com) for up-to-date usage instructions.\r\n\r\n## Supported Platforms\r\n\r\nBerkshelf is tested on Ruby 1.9.3, 2.0, and 2.1.\r\n\r\nRuby 1.9 mode is required on all interpreters.\r\n\r\nRuby 1.9.1 and 1.9.2 are not officially supported. If you encounter problems, please upgrade to Ruby 2.0 or 1.9.3.\r\n\r\n## Configuration\r\n\r\nBerkshelf will search in specific locations for a configuration file. In order:\r\n\r\n    $PWD/.berkshelf/config.json\r\n    $PWD/berkshelf/config.json\r\n    $PWD/berkshelf-config.json\r\n    $PWD/config.json\r\n    ~/.berkshelf/config.json\r\n\r\nYou are encouraged to keep project-specific configuration in the `$PWD/.berkshelf` directory. A default configuration file is generated for you, but you can update the values to suit your needs.\r\n\r\n## Shell Completion\r\n\r\n- [Bash](https://github.com/berkshelf/berkshelf-bash-plugin)\r\n- [ZSH](https://github.com/berkshelf/berkshelf-zsh-plugin)\r\n\r\n## Plugins\r\n\r\nPlease see [Plugins page](https://github.com/berkshelf/berkshelf/blob/master/PLUGINS.md) for more information.\r\n\r\n## Getting Help\r\n\r\n* If you have an issue: report it on the [issue tracker](https://github.com/berkshelf/berkshelf/issues)\r\n* If you have a question: visit the #chef or #berkshelf channel on irc.freenode.net\r\n\r\n## Authors\r\n\r\n[The Berkshelf Core Team](https://github.com/berkshelf/berkshelf/wiki/Core-Team)\r\n\r\nThank you to all of our [Contributors](https://github.com/berkshelf/berkshelf/graphs/contributors), testers, and users.\r\n\r\nIf you'd like to contribute, please see our [contribution guidelines](https://github.com/berkshelf/berkshelf/blob/master/CONTRIBUTING.md) first.\r\n",
      "owner": "reset"
    }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok| The requested tool exists.
   * - ``400``
     - |response code 400 unsuccessful| The requested tool does not exist. For example:

       .. code-block:: javascript

          {
             "error_messages":
             ["Resource does not exist"],
             "error_code": "NOT_FOUND"
          }
