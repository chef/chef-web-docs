+++
title = "Quick Start"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/quick_start.html"]
product = ["client", "server"]

[menu]
  [menu.infra]
    title = "Quick Start"
    identifier = "chef_infra/getting_started/quick_start.md Quick Start"
    parent = "chef_infra/getting_started"
    weight = 20
+++

The quickest way to get started using Chef Infra is to install Chef Workstation and create your first Chef Infra Cookbook:

1.  Install Chef Workstation:
    <https://downloads.chef.io/tools/workstation>.

2.  Generate a Chef Infra repository with an example cookbook:

    ```bash
    chef generate repo my_first_repo
    ```

    where `my_first_repo` is an arbitrary name for your Chef Infra repository.

3.  Navigate to the `cookbooks/example` directory.

4.  Update the `cookbooks/example/recipes/default.rb` recipe in
    the generated cookbook to contain:

    ```ruby
    file "#{ENV['HOME']}/test.txt" do
      content 'This file was created by Chef Infra!'
    end
    ```

5.  Run Chef Infra Client using the `default.rb` recipe:

    ```bash
    chef-client --local-mode --override-runlist example
    ```

This creates a file named `test.txt` at the home path on your computer. Open that file and it will say `This file was created by Chef Infra!`.

- Delete the file, run Chef Infra Client again, and Chef Infra will replace the file.
- Change the string in the file, run Chef Infra Client again, and Chef Infra will make the string in the file the same as the string in the recipe.
- Change the string in the recipe, run Chef Infra Client again, and Chef Infra will update that string to be the same as the one in the recipe.

There's a lot more that Chef Infra can do, obviously, but that was super
easy!

- See <https://learn.chef.io/> for more detailed setup scenarios.
- Keep reading for more information about setting up a workstation,
    configuring Test Kitchen to run virtual environments, setting up a
    more detailed cookbook, resources, and more.
