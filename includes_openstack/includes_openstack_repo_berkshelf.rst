.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |openstack chef_repo| uses |berkshelf| (https://berkshelf.com) to manage downloading all of the proper cookbook versions, whether from |git| or from the |company_name| community website (https://supermarket.chef.io). The preference is to eventually upstream all cookbook dependencies to the |company_name| community website. A |berksfile| (the file type used by |berkshelf|) lists the current cookbook dependencies.
