.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Many |windows powershell_dsc_short| resources are comparable to built-in |chef| resources. For example, both |windows powershell_dsc_short| and |chef| have |resource file|, |resource package|, and |resource service| resources. The |resource dsc_script| resource is most useful for those |windows powershell_dsc_short| resources that do not have a direct comparison to a resource in |chef|, such as the ``Archive`` resource, a custom |windows powershell_dsc_short| resource, an existing |windows powershell_dsc_short| script that performs an important task, and so on. Use the |resource dsc_script| resource to embed the code that defines a |windows powershell_dsc_short| configuration directly within a |chef| recipe.
