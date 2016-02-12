.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``test`` argument to test a cookbook for syntax errors. This argument uses |ruby| syntax checking to verify every file in a cookbook that ends in .rb and |erb|. This argument will respect |chefignore| files when determining which cookbooks to test for syntax errors.


