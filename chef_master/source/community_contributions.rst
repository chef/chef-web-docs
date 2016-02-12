=====================================================
Community Contributions
=====================================================

We are glad you want to contribute to Chef! Here's how:

#. Review the `Become a contributor <https://supermarket.chef.io/become-a-contributor>`_ page on |supermarket| and follow the steps described there for signing the contributor license agreement; both individuals and companies must sign the contributor licensing agreement unless the fix is an `Obvious Fix <https://docs.chef.io/community_contributions.html#the-obvious-fix-rule>`_
#. Create a |github| pull request
#. Do a `code review <https://github.com/chef/chef/blob/master/CONTRIBUTING.md#cr>`_ with the |company_name| team and/or core committers on the pull request

|company_name| regularly reviews contributions and will get back to you if we have any suggestions or concerns.

|company_name|-managed open source projects are located here: https://github.com/chef. See https://github.com/chef/chef/blob/master/CONTRIBUTING.md for more information about the contribution process itself. See below for more information about CLAs, the |apache| license, and the obvious fix rule.


About CLAs and CCLAs
=====================================================
A contributor licensing agreement (CLA) and/or a company contributor licensing agreement (CCLA) must be filled out by every contributor to an |company_name|-managed open source project.

The CLA (and CCLA) makes everyone's rights clear

* You (or your company) grant copyright license for your contributions to |company_name|
* You (or your company) grant patent license for your contributions to |company_name|
* The contribution is entirely voluntary
* The work is your original creation
* You (or your company) are not required to provide support for your contributions
* You (or your company) should read and understand the entire CLA (or CCLA) before signing it. Our description of it is not legally binding.

The CLA is beneficial to our contributors and users because:

* It ensures that we will always be able to release our projects, free from any individual contributor revoking our rights to distribute their contribution.
* This also means that, if you fork an |company_name| project, or utilize it in a commercial product, you know that you are clear of patent and copyright issues.
* It makes clear what is required of our contributors.
* The most important thing about the CLA is that it doesn't give |company_name| any special rights - it just makes things more explicit.

|company_name| does not merge any pull requests made against an |company_name|-managed open source repository until that pull request is associated with a signed CLA (or CCLA), with two exceptions: "Obvious Fixes" and pull requests made against the documentation repository (https://github.com/chef/chef-docs).

About the |apache| License
=====================================================
|company_name| uses the Apache License Version 2 because it provides the same level of freedom for our users that we desire for ourselves. Based upon the Apache Licensing FAQ, it allows you to:

* freely download and use |company_name| software, in whole or in part, for personal, company internal, or commercial purposes;
* use |company_name| software in packages or distributions that you create.

It forbids you to:

* redistribute any piece of |company_name|-originated software without proper attribution;
* use any marks owned by |company_name| in any way that might state or imply that |company_name| endorses your distribution;
* use any marks owned by |company_name| in any way that might state or imply that you created the |company_name| software in question.

It requires you to:

* include a copy of the license in any redistribution you may make that includes |company_name| software;
* provide clear attribution to |company_name| for any distributions that include |company_name| software; attribution can be done in the NOTICE file for an application, by adding yourself as an author/copyright holder to the HEADER for an individual file, and by placing text in a header file saying that new work is based on previous work
* reuse work as long as the licensing terms of the reused work remains unchanged (i.e. The Apache License Version 2 also applies to the reused work)

It does not require you to:

* include the source of the |company_name| software itself, or of any modifications you may have made to it, in any redistribution you may assemble that includes it;
* submit changes that you make to the software back to |company_name| (though such feedback is encouraged).

It is our goal to run a successful, truly open source business. To that end, we are protecting our own rights by making them explicit in our choice of licensing: you have the same rights to our open source software that we do.

The "Obvious Fix" Rule
=====================================================
|company_name|'s contribution policy is aimed at encouraging broad participation from our community, and minimizing risks to |chef| and our community due to inappropriate contributions of the intellectual property of others.

As a general standard, |company_name| requires every contributor to fill out a Contributor License Agreement ("CLA"), either individually or on behalf of a corporation.

HOWEVER, very small contributions such as fixing spelling errors, where the content is small enough to not be considered intellectual property, can be submitted by a contributor as a patch, without a CLA. If you submit an obvious fix without first signing a contributor license agreement, then you are agreeing that your submission is not independently copyrightable. The purpose of this exception is to lower the barrier for new contributors to make contributions while retaining the integrity of the project and our community.

How does the Obvious Fix Rule Work?
-----------------------------------------------------
Any committer may commit fixes without first signing a CLA for obvious typos, grammar mistakes, and formatting problems wherever they may be — in the web pages, API documentation, source code, etc.

Whenever you invoke the "obvious fix" rule, please say so in your commit message. For example:

.. code-block:: bash

   ------------------------------------------------------------------------
   commit 370adb3f82d55d912b0cf9c1d1e99b132a8ed3b5 
   Author: danielsdeleo <dan@chef.io> 
   Date:   Wed Sep 18 11:44:40 2013 -0700      
   
     Fix typo in config file docs.          
   
     Obvious fix.
   
   ------------------------------------------------------------------------

What qualifies as an Obvious Fix?
-----------------------------------------------------
An obvious fix is a pull request that does not contain creative work. We rely on your judgment to determine what is "obvious"; if you're not sure, just ask by sending an email to: oss AT getchef DOT com.

As a rule of thumb, changes are obvious fixes if they do not introduce any new functionality or creative thinking. As long as the change does not affect functionality, some likely examples include the following:

* Spelling/grammar fixes;
* Correcting typos;
* Cleaning up comments in the code;
* Changes to white space or formatting;
* Bug fixes that change default return values or error codes stored in constants, literals, or simple variable types;
* Adding logging messages or debugging output;
* Changes to 'metadata' files like Gemfile, rebar.config, Makefile, app.config, sys.config, .gitignore, example configuration files, build scripts, etc.;
* Changes that reflect outside facts, like renaming a build directory or changing a constant;
* Changes in build or installation scripts;
* Re-ordering of objects or subroutines within a source file (such as alphabetizing routines);
* Moving source files from one directory or package to another, with no changes in code;
* Breaking a source file into multiple source files, or consolidating multiple source files into one source file, with no change in code behavior; 
* Changes to words or phrases isolated from their context;
* Changes to typeface.

Things that would still require signing a CLA before submitting would likely include stuff like the following:

* Any of the above actions that result in a change in functionality;
* A new feature;
* A translation;
* Extensive or creative comments.

Issues and Bug Reports
=====================================================
Issues and bug reports may be created for |company_name| products, including the |chef client|, the |chef dk|, the |chef server|, the |chef analytics| platform, and the |chef manage| WebUI. The following repositories are the preferred locations for the creation of issues and bug reports:

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Repo
     - URL
   * - |chef client|
     - https://github.com/chef/chef
   * - |chef dk_title|
     - https://github.com/chef/chef-dk
   * - |chef server_title|
     - https://github.com/chef/chef-server
   * - |chef manage_title|
     - https://github.com/chef/chef-manage-issues
   * - |chef analytics_title|
     - https://github.com/chef/chef-analytics
   * - |push jobs_title|
     - https://github.com/chef/chef-push
   * - |chef delivery|
     - please contact `Chef Support <https://www.chef.io/support/>`_ 

For additional support about |company_name| products, including documentation, learning, and opening tickets with the support team, see `Chef Support <https://www.chef.io/support/>`_ .

.. warning:: If you require a response from |company_name| per the terms of a support level agreement (SLA), please contact `Chef Support <https://www.chef.io/support/>`_ directly.

.. note:: Questions on how to use Chef should be sent as Support Tickets if you have an SLA, or asked on the `Chef Mailing List <https://discourse.chef.io/>`_, `Stack Overflow <http://stackoverflow.com/questions/tagged/chef>`_, or `IRC <http://irc.lc/freenode/chef>`_. Bug Trackers are not appropriate for general purpose questions that are not bugs.


Use |git|
=====================================================
.. include:: ../../includes_chef_repo/includes_chef_repo_git.rst

Set Up Repo
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_git_master_setup.rst

Keep Master Current
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_git_master_keep_current.rst

Sync Master
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_git_master_sync.rst

Use Branch
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_git_branch.rst

Delete Branch
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_git_branch_delete.rst
