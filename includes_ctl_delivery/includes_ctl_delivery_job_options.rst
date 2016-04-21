.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


This subcommand has the following options:

``-b=BRANCH``, ``--branch=BRANCH``
   |delivery branch|

``-C=CHANGE``, ``--change=CHANGE``
   |delivery branch|

``--change-id=ID``
   |id delivery_change|

``--docker=IMAGE``
   |delivery docker_image|

``-e=ENTERPRISE``, ``--ent=ENTERPRISE``
   |delivery enterprise|

``-f=PIPELINE``, ``--for=PIPELINE``
   |delivery pipeline|

``-g=URL``, ``--git-url=URL``
   |git url| This URL is used as the remote target for the local |git| checkout when the job is run. If this option is used, the ``--ent``, ``--org``, ``--server``, and ``--user`` options are ignored.

``-j=PATH``, ``--job-root=PATH``
   |path delivery_job_root|

``-l``, ``--local``
   |delivery run_local|

``-n``, ``--no-spinner``
   |delivery no_spinner|

``-o=ORGANIZATION``, ``--org=ORGANIZATION``
   |delivery organization|

``-p=PROJECT``, ``--project=PROJECT``
   |name delivery_project|

``-P=NUMBER``, ``--patchset=NUMBER``
   |delivery patchset| Default value: ``latest``.

``<phase>``
   |delivery phase|

``-s=SERVER``, ``--server=SERVER``
   |delivery server|

``-S=GIT_SHA``, ``--shasum=GIT_SHA``
   |git sha|

``--skip-default``
   |delivery skip_default_recipe|

``-u=USER``, ``--user=USER``
   |delivery user|
