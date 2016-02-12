.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|chef bookshelf| is used to store cookbook content---files, templates, and so on---that have been uploaded to the |chef server| as part of a cookbook version. Cookbook content is stored by content checksum. If two different cookbooks or different versions of the same cookbook include the same file or template, |chef bookshelf| will store that file only once. The cookbook content managed by |chef bookshelf| is stored in flat files and is separated from the |chef server| and search index repositories.
