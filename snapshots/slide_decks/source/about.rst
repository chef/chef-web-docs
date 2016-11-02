

================================================
About Slide Decks
================================================

.. revealjs::

 .. revealjs:: Slide Decks from chef-docs

  .. tag slides_core_splash

  .. Use this slide as the very first slide in every slide deck. The title of this slide (as included in the slide map file) is what identifies the training.

  .. image:: ../../images/slides_splash.png

  .. end_tag

  .. rv_note::

     This is a speaker note. Hit "s" on the keyboard to view them.

 .. revealjs:: What is Sphinx?

  Sphinx is a document authoring platform that:

  * Uses a whitespace-delimited authoring format called reStructuredText (and is similar to Markdown)
  * Uses the docutils parser/library---builds to HTML, PDF, man-page, reveal.js (slide decks), and other formats
  * Is Python-based---can be extended using the Python platform
  * Does way more than render pages, it also tests the page and ensures valid content and structure
  * Separates source (.rst files), structure ("map files"), and presentation (CSS, etc.)
  * Composable, reusable, and delightful

 .. revealjs:: What are slide decks from chef-docs?

  Slide decks built from chef-docs:

  * Build reveal.js presentations using the same authoring platform and build pipeline as chef-docs
  * Are continuously delivered: update file > check into git > Jenkins magic > live online in minutes
  * Enable single-sourcing of slides---publish the same slide to many places, as needed
  * May source material from the chef-docs library, as needed
  * Are a candidate to replace the PowerPoint/Keynote decks currently used for training

 .. revealjs:: Some Slide Basics

  Slides should begin with simple, concise statements followed by a short list. Slides uses a very small subset of the Sphinx directive set:

  * Paragraphs, including **bold**, *italics*, and ``code``
  * Ordered and unordered lists
  * Fully qualified URLs
  * Code blocks, both by themselves and within ordered lists
  * Images. Used well, images are terrific! Used poorly, well ...
  * List-tables, which are tables built using an unordered list and whitespace
  * Notes, warnings

  Titles are in all-caps and live in the slide map file, separate from the contents of the reStructuredText file. For more information see https://docs.chef.io/style_guide.html#slide-decks.

  .. warning:: Slides do support speaker notes, like this: ``.. rv_note:: This is a speaker note.`` Hit the ``s`` key on the keyboard to view speaker notes.

  .. rv_note:: This is a speaker note.

 .. revealjs:: Bash

  Run:

  .. code-block:: bash

     $ some -bash "command"

  For example:

  .. code-block:: bash

     $ sudo chef-apply hello.rb

  Returns:

  .. code-block:: none

     Recipe: (chef-apply cookbook)::(chef-apply recipe)
       * file[hello.txt] action create (up to date)

 .. revealjs:: Ruby

  Ruby code:

  .. code-block:: ruby

     some 'ruby' do
       stuff
     end

  For example, a Desired State Configuration (DSC) script:

  .. code-block:: ruby

     dsc_script 'emacs' do
       code <<-EOH
         Environment 'texteditor'
           {
             Name = 'EDITOR'
             Value = 'c:\\emacs\\bin\\emacs.exe'
           }
       EOH
     end

 .. revealjs:: JSON

  JSON code:

  .. code-block:: javascript

     {
       some: json_data
     }

  For example, node data:

  .. code-block:: javascript

     {
       "name": "node_name",
       "chef_environment": "_default",
       "run_list": [
         "recipe[recipe_name]"
       ]
       "json_class": "Chef::Node",
       "chef_type": "node",
       "automatic": { ... },
       "normal": { "tags": [ ] },
       "default": { },
       "override": { } 
     }

 .. revealjs:: Yaml

  Some YAML:

  .. code-block:: yaml

     ---
     section:
       property: value
       etc...

  For example, .kitchen.yml file with two platforms and one test suite:

  .. code-block:: yaml

     ---
     driver:
       name: vagrant

     provisioner:
       name: chef_zero

     platforms:
       - name: ubuntu-12.04

     suites:
       - name: default
         run_list:
           - recipe[apache::default]

 .. revealjs:: Fragments

  .. rst-class:: fragment

     Hit the next arrow...

     .. raw:: html

        <ol>
        <li class="fragment"><code>fragment one</code></li>
        <li class="fragment"><em>fragment two</em></li>
        <li class="fragment"><strong>fragment three</strong></li>
        </ol>

 .. revealjs:: Images

  .. image:: ../../images/rubocop_output_slides.png

 .. revealjs:: Tables Topic

  .. list-table::
     :widths: 60 420
     :header-rows: 1

     * - Feature
       - Description
     * - Final Feature 1
       - Description for REALS!
     * - Final Feature 2
       - Description for REALS!
     * - Final Feature 3
       - Description for REALS!

 .. revealjs:: Notes and Warnings

  Notes and warnings! (Use sparingly.)

  .. note:: This is a note. Use this as a visual separator to occasionally refer to something important. It's blue so it's less obvious on the page.

  .. warning:: This is a warning! Use this as a visual separator to remind people when they might break something. Or maybe to say something pithy and true. It's bright yellow to ensure that everyone actually sees it.

  Resist the urge to use them. They are more useful that way.

 .. revealjs:: Images -- Resource Types

  .. Use this slide to introduce the resource types that are built-in to the chef-client; these are the "most popular" resources, not all of them.

  .. image:: ../../images/slides_splash_resources.png

 .. revealjs:: Images -- Node Types

  .. Use this slide to introduce the node types on which the chef-client can run.

  .. image:: ../../images/slides_splash_node_types.png

 .. revealjs:: Speaker Notes

    You can use speaker notes by adding the ``.. rv_note::`` directive to a slide.

    Hit "s" on your keyboard to view the notes.

    .. code-block:: none

       .. rv_note::

          This is a speaker note. You found this from your keyboard's "s" key.

 .. revealjs:: Embed HTML

    Use the ``.. raw:: html`` directive to add HTML to a page. For example, a video:

    .. raw:: html

       <iframe width="800" height="500" src="https://www.youtube.com/embed/0P0HD5pE-zU" frameborder="0" allowfullscreen></iframe>

 .. revealjs:: Questions?

  .. tag slides_core_questions

  .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

  .. image:: ../../images/slides_questions.png

  .. end_tag

 .. revealjs:: Let's Hack!

  .. tag slides_core_hack

  .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

  .. image:: ../../images/slides_hack.png

  .. end_tag

.. revealjs::

 .. revealjs:: Resources

  .. tag resources_common

  A resource is a statement of configuration policy that:

  * Describes the desired state for a configuration item
  * Declares the steps needed to bring that item to the desired state
  * Specifies a resource type---such as ``package``, ``template``, or ``service`` 
  * Lists additional details (also known as resource properties), as necessary
  * Are grouped into recipes, which describe working configurations

  .. end_tag

 .. revealjs:: package

  .. tag slides_resources_type_package

  A package to be installed:

  .. code-block:: ruby

     package 'haproxy' do
      action :install
     end

  .. end_tag

 .. revealjs:: template

  .. tag slides_resources_type_template

  A file to be generated from a template:

  .. code-block:: ruby

     template '/etc/haproxy/haproxy.cfg' do
       source 'haproxy.cfg.erb'
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[haproxy]'
     end

  .. end_tag

 .. revealjs:: service

  .. tag slides_resources_type_service

  A service that should be started:

  .. code-block:: ruby

     service 'haproxy' do
       supports :restart => :true
       action [:enable, :start]
     end

  .. end_tag

 .. revealjs:: Recipe Order Matters

  .. tag slides_recipes_order

  .. code-block:: ruby

     package 'haproxy' do
      action :install
     end

     template '/etc/haproxy/haproxy.cfg' do
       source 'haproxy.cfg.erb'
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[haproxy]'
     end

     service 'haproxy' do
       supports :restart => :true
       action [:start, :enable]
     end

  .. end_tag

 .. revealjs:: Package Runs First

  .. tag slides_recipes_order_package

  .. code-block:: ruby

     package 'haproxy' do
       action :install
     end

  .. code-block:: ruby

     template '/etc/haproxy/haproxy.cfg' do
       source 'haproxy.cfg.erb'
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[haproxy]'
     end

     service 'haproxy' do
       supports :restart => :true
       action [:start, :enable]
     end

  .. end_tag

 .. revealjs:: Template Runs Second

  .. tag slides_recipes_order_template

  .. code-block:: ruby

     package 'haproxy' do
       action :install
     end

  .. code-block:: ruby

     template '/etc/haproxy/haproxy.cfg' do
       source 'haproxy.cfg.erb'
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[haproxy]'
     end

  .. code-block:: ruby

     service 'haproxy' do
       supports :restart => :true
       action [:start, :enable]
     end

  .. end_tag

 .. revealjs:: Service Runs Third

  .. tag slides_recipes_order_service

  .. code-block:: ruby

     package 'haproxy' do
       action :install
     end

     template '/etc/haproxy/haproxy.cfg' do
       source 'haproxy.cfg.erb'
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[haproxy]'
     end

  .. code-block:: ruby

     service 'haproxy' do
       supports :restart => :true
       action [:start, :enable]
     end

  .. end_tag

 .. revealjs:: More Info About Resources

    For more information, see:

    * https://docs.chef.io/resources.html
    * https://docs.chef.io/recipes.html
