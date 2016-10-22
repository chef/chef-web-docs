.. THIS PAGE IS LOCATED AT THE /decks/ PATH.

================================================
About Chef Documentation
================================================

.. revealjs::

 .. revealjs:: Architecture

  .. image:: ../../images/docs_architecture.svg

 .. revealjs:: reStructuredText Topics

    A reStructuredText topic is:

    * A small file located in an ``includes_`` folder
    * Authored to be clear, concise, true, standalone
    * A building block
    * Included into one (or more) map files
    * Often true for more than the "current version"

 .. revealjs:: RST Maps

    A RST map:

    * Defines the structure of a topic (H1, H2, H3, H4)
    * Declares paths to topics to be included into that structure, at the point it is declared
    * May contain content that is unique to the map
    * Is a standalone topic specific to a deliverable
    * Once published a map is the same as an HTML page, a man page, a PDF, and so on

 .. revealjs:: Deliverables

    A deliverable:

    * Is to a single output format, i.e. "HTML" or "man page"
    * Contains all of the information about an application, a feature, or a component within an application, depending on the deliverable
    * For HTML deliverables, typically is many standalone HTML topics built together into a unified web site with navigation, search, and versioning
    * For other deliverables, typically is a specific subset of information, such as a man page about a single command line tool, a reference page for a single resource, and so on

 .. revealjs:: Sphinx

    Sphinx is a content management tool that:

    * Builds docs collections---HTML, PDF, man page, reStructuredText, Reveal.js
    * Validates the structure of each doc collection, each RST map within that doc collection, each topic included in each RST map
    * Applies the correct theme for the output format declared for the doc collection
    * Validates the markup within each topic and RST map---internal links, formatting, structure, etc.---for all files in the doc collection

 .. revealjs:: Repository

    The document repository is a location under version source control that:

    * Probably uses git and GitHub, but any version source control system works
    * Should be configured to build and validate every doc collection continuously
    * Should be configured to publish every doc collection on a periodic basis, ideally as often as the docs collection is built and validated

 .. revealjs:: Continuous Delivery

    Each doc collection is built continuously, and then delivered. Chef documentation uses:

    * Chef Automate
    * A public repo on GitHub: https://github.com/chef/chef-web-docs
    * HTML and Reveal.js pages are published to https://docs.chef.io several times per day
    * Other formats are published to various repositories, as needed

 .. revealjs:: Authoring

  .. image:: ../../images/docs_process.svg

 .. revealjs:: Questions?

  .. include:: ../../includes_slides/includes_slides_core_questions.rst

 .. revealjs:: Let's Hack!

  .. include:: ../../includes_slides/includes_slides_core_hack.rst

 .. revealjs:: More Info About Authoring Chef Docs

    For more information, see:

    * https://docs.chef.io/style_guide.html
    * https://github.com/chef/chef-web-docs
