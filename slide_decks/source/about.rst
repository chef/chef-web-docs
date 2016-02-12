.. THIS PAGE IS LOCATED AT THE /decks/ PATH.

================================================
About Slide Decks
================================================

.. revealjs::

 .. revealjs:: Slide Decks from chef-docs

  .. include:: ../../includes_slides/includes_slides_core_splash.rst

  .. rv_note:: 

     This is a speaker note. Hit "s" on the keyboard to view them.

 .. revealjs:: What is Sphinx?

  .. include:: ../../includes_slides/includes_slides_demo_sphinx.rst

 .. revealjs:: What are slide decks from chef-docs?

  .. include:: ../../includes_slides/includes_slides_demo_about.rst

 .. revealjs:: Some Slide Basics

  .. include:: ../../includes_slides/includes_slides_demo_simple_slides.rst

 .. revealjs:: Bash

  .. include:: ../../includes_slides/includes_slides_demo_code_bash.rst

 .. revealjs:: Ruby

  .. include:: ../../includes_slides/includes_slides_demo_code_ruby.rst

 .. revealjs:: JSON

  .. include:: ../../includes_slides/includes_slides_demo_code_json.rst

 .. revealjs:: Yaml

  .. include:: ../../includes_slides/includes_slides_demo_code_yaml.rst

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

  .. include:: ../../includes_slides/includes_slides_demo_table.rst

 .. revealjs:: Notes and Warnings

  .. include:: ../../includes_slides/includes_slides_demo_admonitions.rst

 .. revealjs:: Images -- Resource Types

  .. include:: ../../includes_slides/includes_slides_core_resources.rst

 .. revealjs:: Images -- Node Types

  .. include:: ../../includes_slides/includes_slides_core_node_types.rst

 .. revealjs:: Speaker Notes

    You can use speaker notes by adding the ``.. rv_note::`` directive to a slide.

    Hit "s" on your keyboard to view the notes.

    .. code-block:: ruby

       .. rv_note:: 

          This is a speaker note. You found this from your keyboard's "s" key.

 .. revealjs:: Embed HTML

    Use the ``.. raw:: html`` directive to add HTML to a page. For example, a video:

    .. raw:: html

       <iframe width="800" height="500" src="https://www.youtube.com/embed/0P0HD5pE-zU" frameborder="0" allowfullscreen></iframe>

 .. revealjs:: Questions?

  .. include:: ../../includes_slides/includes_slides_core_questions.rst

 .. revealjs:: Let's Hack!

  .. include:: ../../includes_slides/includes_slides_core_hack.rst


.. revealjs::

 .. revealjs:: Resources

  .. include:: ../../includes_resources_common/includes_resources_common.rst

 .. revealjs:: package

  .. include:: ../../includes_slides/includes_slides_resources_type_package.rst

 .. revealjs:: template

  .. include:: ../../includes_slides/includes_slides_resources_type_template.rst

 .. revealjs:: service

  .. include:: ../../includes_slides/includes_slides_resources_type_service.rst

 .. revealjs:: Recipe Order Matters

  .. include:: ../../includes_slides/includes_slides_recipes_order.rst

 .. revealjs:: Package Runs First

  .. include:: ../../includes_slides/includes_slides_recipes_order_package.rst

 .. revealjs:: Template Runs Second

  .. include:: ../../includes_slides/includes_slides_recipes_order_template.rst

 .. revealjs:: Service Runs Third

  .. include:: ../../includes_slides/includes_slides_recipes_order_service.rst

 .. revealjs:: More Info About Resources

    For more information, see:

    * https://docs.chef.io/resources.html
    * https://docs.chef.io/recipes.html
