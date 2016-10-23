.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``install`` argument to install a cookbook that has been downloaded from the community site to a local git repository . This action uses the git version control system in conjunction with the |url community_cookbooks| site to install community-contributed cookbooks to the local chef-repo. Using this argument does the following:

  #. A new "pristine copy" branch is created in git for tracking the upstream.
  #. All existing versions of a cookbook are removed from the branch.
  #. The cookbook is downloaded from |url community_cookbooks| in the tar.gz format.
  #. The downloaded cookbook is untarred and its contents are committed to git and a tag is created.
  #. The "pristine copy" branch is merged into the master branch.
  
This process allows the upstream cookbook in the master branch to be modified while letting git maintain changes as a separate patch. When an updated upstream version becomes available, those changes can be merged while maintaining any local modifications.

